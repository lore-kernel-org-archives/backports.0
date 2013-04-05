Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:43861 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162779Ab3DEWFS (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Apr 2013 18:05:18 -0400
Message-ID: <1365199513.8515.41.camel@jlt4.sipsolutions.net> (sfid-20130406_000520_949452_8BE3B7F6)
Subject: Re: [PATCH v3 6/8] backports: add NFC patches
From: Johannes Berg <johannes@sipsolutions.net>
To: Thierry Escande <thierry.escande@linux.intel.com>
Cc: backports@vger.kernel.org
Date: Sat, 06 Apr 2013 00:05:13 +0200
In-Reply-To: <1365196842-12992-6-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_232057_706413_B1DD1995)
References: <1365196842-12992-6-git-send-email-thierry.escande@linux.intel.com>
	 (sfid-20130405_232057_706413_B1DD1995)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-04-05 at 23:20 +0200, Thierry Escande wrote:

>  .../network/53-pr_fmt/net_nfc_core.patch           |   13 ++++
>  .../network/53-pr_fmt/net_nfc_hci_command.patch    |   13 ++++
>  .../network/53-pr_fmt/net_nfc_hci_core.patch       |   13 ++++
>  .../network/53-pr_fmt/net_nfc_hci_hcp.patch        |   13 ++++
>  .../network/53-pr_fmt/net_nfc_hci_llc_shdlc.patch  |   13 ++++
>  .../network/53-pr_fmt/net_nfc_llcp_commands.patch  |   13 ++++
>  .../network/53-pr_fmt/net_nfc_llcp_llcp.patch      |   13 ++++
>  .../network/53-pr_fmt/net_nfc_llcp_sock.patch      |   13 ++++
>  .../network/53-pr_fmt/net_nfc_nci_core.patch       |   13 ++++
>  .../network/53-pr_fmt/net_nfc_nci_data.patch       |   13 ++++
>  .../network/53-pr_fmt/net_nfc_nci_ntf.patch        |   13 ++++
>  .../network/53-pr_fmt/net_nfc_nci_rsp.patch        |   12 ++++
>  .../network/53-pr_fmt/net_nfc_netlink.patch        |   13 ++++
>  .../network/53-pr_fmt/net_nfc_rawsock.patch        |   13 ++++

FWIW, it's probably more efficient to just put them all into one
net_nfc.patch file. The only reason they're split by *file* rather than
by *logical group* right now is that it was easy to do automatically and
solved the problem I had (of wanting to copy only some drivers and then
applying only some patches). For this it's not really needed or even
useful to split by file, it was just the fastest way :-)

So I think it'd make sense to put it into a single file, but I'm happy
to apply it as-is as well (though I want to give others more time to
review, so I'll not do it today)

johannes

