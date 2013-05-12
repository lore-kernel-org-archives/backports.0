Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:44596 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab3ELTdd (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 12 May 2013 15:33:33 -0400
Received: by mail-la0-f50.google.com with SMTP id dz20so1609464lab.37
        for <backports@vger.kernel.org>; Sun, 12 May 2013 12:33:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANq1E4Re_uJQqvqEpWzRbVxsxVz3MBvZUqzM3ONFiJ+mXy4rNA@mail.gmail.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
 <1368232023-23817-12-git-send-email-mcgrof@do-not-panic.com> <CANq1E4Re_uJQqvqEpWzRbVxsxVz3MBvZUqzM3ONFiJ+mXy4rNA@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sun, 12 May 2013 12:33:11 -0700
Message-ID: <CAB=NE6XrKUSDQbjdeht=Aip-E1=oqPd4D=JmMdEdrJSNXLGukg@mail.gmail.com> (sfid-20130512_213336_581514_7F7F8FA3)
Subject: Re: [PATCH 11/12] backports: backport new bluetooth hidp session-management
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, May 12, 2013 at 5:26 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> On Sat, May 11, 2013 at 2:27 AM, Luis R. Rodriguez <mcgrof@do-not-panic.com> wrote:
>> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>
> I never worked with the backports tree, so excuse me if I am not
> entirely sure about all of this. I also doubt that it introduces
> regressions, as it actually was intended to fix 5-year old
> regressions.. Anyhow, I can try.

No worries and forgive us for the lack of up to date documentation but
in between the last part of the development cycle for v3.10 Johannes
made some huge changes that we're incorporating into the releases
planned based on v3.10, and two new subsystems were added, as it is
now a new temporary tree is being used for development which I then
will fork on kernel.org once ready for releases. I will add the
documentation required but for now we've just been trying to catch up
to each linux-next tag to ensure we can get a release brewed in time
for the v3.10 release (rc1 is out today). Progress is good though.

The temporary tree is:

git://git.sipsolutions.net/backports.git

Then I have 26 patch delta on top of this which for now you can get here:

http://drvbp1.linux-foundation.org/~mcgrof/backport-tmp/pending-next-20130426.patch

You can git am that. That would get you up to my latest changes. The
change we are reviewing here in this thread is commit
b8d21c2845038e334c8976b7f54e921afcbc7924 once that delta is applied.

To generate a release you'd need a linux-next tree as well reset to
next-20130426 and then from the backports tree you can do:

./gentree.py --verbose /home/mcgrof/linux-next
/home/mcgrof/build/backports-20130426

> Is there a more recent version of the 16-bluetooth/ patches, or do I
> need to generate these myself? I only found
>   https://git.kernel.org/cgit/linux/kernel/git/mcgrof/compat-drivers.git/tree/patches/collateral-evolutions/network/16-bluetooth.patch
> which is definitely too old.

Indeed, given the current state of affairs of development on the
backports project to make things easier for you you can either get the
changes as described above or I can give you a temporary tarball and
if you can send me the delta to what you think should go in place?

http://drvbp1.linux-foundation.org/~mcgrof/backport-tmp/backports-20130426.tar.bz2

If you'd like to build, just make menuconfig on whatever kernel you're on.

Feel free to use whatever works best for you and I really appreciate
you taking time to review this.

>> +       /* check that no other session for this device exists */
>> +@@ -1057,6 +1181,16 @@ static int hidp_session_probe(struct l2c
>> +               ret = -EEXIST;
>> +               goto out_unlock;
>>         }
>> -+#else
>> ++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,27))
>>  +      if (session->input) {
>>  +              err = hidp_setup_input(session, req);
>>  +              if (err < 0)
>> @@ -192,29 +198,16 @@
>>  +              hidp_setup_hid(session, req);
>>  +#endif
>
> This looks wrong. hidp_session_probe() no longer handles input/hid
> devices. This should be done in hidp_session_dev_init().

Got it.

>> -       hidp_set_timer(session);
>> -
>> -@@ -1097,6 +1225,7 @@ unlink:
>> -               session->input = NULL;
>> -       }
>> -
>> -+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27))
>> -       if (session->hid) {
>> -               hid_destroy_device(session->hid);
>> -               session->hid = NULL;
>> -@@ -1110,10 +1239,15 @@ purge:
>> -
>> -       skb_queue_purge(&session->ctrl_transmit);
>> -       skb_queue_purge(&session->intr_transmit);
>> -+#endif
>> -
>> - failed:
>> +       ret = hidp_session_start_sync(session);
>> +       if (ret)
>> +@@ -1075,6 +1209,10 @@ out_stop:
>> +       hidp_session_terminate(session);
>> + out_unlock:
>>         up_write(&hidp_session_sem);
>> -
>>  +#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,27))
>>  +      if (session->hid)
>>  +              hid_free_device(session->hid);
>>  +#endif
>
> That looks wrong, too, but as it is the bottom half of the diff above,
> it's probably related.

I think patch miserably guessed the hunks where to apply some of these
changes to. I tried to make sense of it but the rewrite was a bit big
so I was not sure where to places things correctly, hence me Cc'ing
you, I really appreciate you reviewing this.

  Luis
