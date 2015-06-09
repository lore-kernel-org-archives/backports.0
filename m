Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36838 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbbFIWSi (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 9 Jun 2015 18:18:38 -0400
Received: by ieclw1 with SMTP id lw1so22784060iec.3
        for <backports@vger.kernel.org>; Tue, 09 Jun 2015 15:18:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
References: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Tue, 9 Jun 2015 15:18:17 -0700
Message-ID: <CAB=NE6XptbAs-bqBaySAGk8Wyut0NYw4C+HOtfP+VOkm-tSLmQ@mail.gmail.com> (sfid-20150610_001840_286267_CAB6B26F)
Subject: Re: [PATCH 0/4] backports: SmPL patch equivalence support
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Jun 5, 2015 at 5:09 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> Luis R. Rodriguez (4):
>   patches: remove bt_sock_stream_recvmsg() and bt_sock_recvmsg() from
>     ifdefs
>   patches: change 0054-struct-proto_ops-sig backport strategy
>   gentree.py: add SmPL patch equivalence proof support
>   patches: provide 0054-struct-proto_ops-sig SmPL patch replacement

FYI - dropped the gentree.py patch for SmPL proof support and pushed the rest.

 Luis
