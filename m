Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34346 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbbINIZd (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 14 Sep 2015 04:25:33 -0400
Received: by obbda8 with SMTP id da8so102751878obb.1
        for <backports@vger.kernel.org>; Mon, 14 Sep 2015 01:25:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1441790875-8496-1-git-send-email-johannes@sipsolutions.net>
References: <1441790875-8496-1-git-send-email-johannes@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 14 Sep 2015 01:25:13 -0700
Message-ID: <CAB=NE6VMH6Ket9CRni2KMiTaAgStUGqDtUoZw4buF0R=9TH_Aw@mail.gmail.com> (sfid-20150914_102536_840858_8385F174)
Subject: Re: [PATCH v2] backports: add spatch to handle IFF_NO_QUEUE
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Sep 9, 2015 at 2:27 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> This flag doesn't exist on newer kernels, but replaced the tx_queue_len
> assignment, so can't just be backported to have no effect. Instead, add
> a semantic patch that puts back the tx_queue_len=0 assignment on older
> kernel versions.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  patches/collateral-evolutions/network/0062-iff-no-queue.cocci | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 patches/collateral-evolutions/network/0062-iff-no-queue.cocci
>
> diff --git a/patches/collateral-evolutions/network/0062-iff-no-queue.cocci b/patches/collateral-evolutions/network/0062-iff-no-queue.cocci
> new file mode 100644
> index 000000000000..9c95b853df18
> --- /dev/null
> +++ b/patches/collateral-evolutions/network/0062-iff-no-queue.cocci
> @@ -0,0 +1,9 @@
> +@@
> +expression E;
> +@@
> +
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
> + E->priv_flags |= IFF_NO_QUEUE;
> ++#else
> ++E->tx_queue_len = 0;
> ++#endif

Interesting so although priv_flags may be a member name prevalent in
*many* data structures the SmPL rule here is very specific about the
use of IFF_NO_QUEUE as a flag, and since we know that is unique to one
use case we take the liberty over using expression here. Replying just
to annotate this practice and Cc Julia on her thoughts.

 Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
