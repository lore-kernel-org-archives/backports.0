Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:36157 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286Ab3DFUXU (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 6 Apr 2013 16:23:20 -0400
Received: by mail-we0-f181.google.com with SMTP id d7so3566326wer.26
        for <backports@vger.kernel.org>; Sat, 06 Apr 2013 13:23:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365199513.8515.41.camel@jlt4.sipsolutions.net>
References: <1365196842-12992-6-git-send-email-thierry.escande@linux.intel.com>
 <1365199513.8515.41.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sat, 6 Apr 2013 13:22:58 -0700
Message-ID: <CAB=NE6VJt2d1JJVe0rbe50rrw-TCTHgOyt9b3ig-RU8ghR2Wbw@mail.gmail.com> (sfid-20130406_222324_086292_802F46D9)
Subject: Re: [PATCH v3 6/8] backports: add NFC patches
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thierry Escande <thierry.escande@linux.intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 5, 2013 at 3:05 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
>
>>  .../network/53-pr_fmt/net_nfc_core.patch           |   13 ++++
>>  .../network/53-pr_fmt/net_nfc_hci_command.patch    |   13 ++++
>>  .../network/53-pr_fmt/net_nfc_hci_core.patch       |   13 ++++
>>  .../network/53-pr_fmt/net_nfc_hci_hcp.patch        |   13 ++++
>>  .../network/53-pr_fmt/net_nfc_hci_llc_shdlc.patch  |   13 ++++
>>  .../network/53-pr_fmt/net_nfc_llcp_commands.patch  |   13 ++++
>>  .../network/53-pr_fmt/net_nfc_llcp_llcp.patch      |   13 ++++
>>  .../network/53-pr_fmt/net_nfc_llcp_sock.patch      |   13 ++++
>>  .../network/53-pr_fmt/net_nfc_nci_core.patch       |   13 ++++
>>  .../network/53-pr_fmt/net_nfc_nci_data.patch       |   13 ++++
>>  .../network/53-pr_fmt/net_nfc_nci_ntf.patch        |   13 ++++
>>  .../network/53-pr_fmt/net_nfc_nci_rsp.patch        |   12 ++++
>>  .../network/53-pr_fmt/net_nfc_netlink.patch        |   13 ++++
>>  .../network/53-pr_fmt/net_nfc_rawsock.patch        |   13 ++++
>
> FWIW, it's probably more efficient to just put them all into one
> net_nfc.patch file. The only reason they're split by *file* rather than
> by *logical group* right now is that it was easy to do automatically and
> solved the problem I had (of wanting to copy only some drivers and then
> applying only some patches). For this it's not really needed or even
> useful to split by file, it was just the fastest way :-)
>
> So I think it'd make sense to put it into a single file, but I'm happy
> to apply it as-is as well (though I want to give others more time to
> review, so I'll not do it today)

How about a directory alone for NFC patches as we do for DRM. In fact
perhaps Bluetooth should be split out from network as well, just as
ethernet. That is, per subsystem.

  Luis
