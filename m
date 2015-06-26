Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35651 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbFZBHQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 25 Jun 2015 21:07:16 -0400
Received: by igblr2 with SMTP id lr2so3885562igb.0
        for <backports@vger.kernel.org>; Thu, 25 Jun 2015 18:07:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434748917-23404-1-git-send-email-mcgrof@do-not-panic.com>
References: <1434748917-23404-1-git-send-email-mcgrof@do-not-panic.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 25 Jun 2015 18:06:51 -0700
Message-ID: <CAB=NE6WB9POGJZMNDxHNgnkV9PZDdEtWwnSJw_mqJezwxnHdog@mail.gmail.com> (sfid-20150626_030719_639426_1CFA1AE5)
Subject: Re: [PATCH] patches: increase 0001-netlink-portid.cocci dependability
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Jun 19, 2015 at 2:21 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> Using expression is pretty flexible, in this case we
> don't want that flexibility as it can override any
> struct who also uses the same variable name. For a
> specific example of the issue refer to the netdev-ops
> demo git tree [0] which provide an example of the issue
> with two SmPL rules.
>
> We keep the expression on the last rule on NETLINK_CB(skb)
> given that we know only an skb can possibly be used on it.
>
> 1   3.0.101             [  OK  ]
> 2   3.1.10              [  OK  ]
> 3   3.2.68              [  OK  ]
> 4   3.3.8               [  OK  ]
> 5   3.4.107             [  OK  ]
> 6   3.5.7               [  OK  ]
> 7   3.6.11              [  OK  ]
> 8   3.7.10              [  OK  ]
> 9   3.8.13              [  OK  ]
> 10  3.9.11              [  OK  ]
> 11  3.10.75             [  OK  ]
> 12  3.11.10             [  OK  ]
> 13  3.12.40             [  OK  ]
> 14  3.13.11             [  OK  ]
> 15  3.14.39             [  OK  ]
> 16  3.15.10             [  OK  ]
> 17  3.16.7              [  OK  ]
> 18  3.17.8              [  OK  ]
> 19  3.18.12             [  OK  ]
> 20  3.19.5              [  OK  ]
> 21  4.0.0               [  OK  ]
> 22  4.1-rc8             [  OK  ]
>
> [0] https://github.com/mcgrof/netdev-ops.git
>
> Cc: cocci@systeme.lip6.fr
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>

Applied and pushed.

 Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
