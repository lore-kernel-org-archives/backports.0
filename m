Return-path: <backports-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:49897 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbeHPIls (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 16 Aug 2018 04:41:48 -0400
Subject: Re: [Cocci] Adjustment for const qualification
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Luciano Coelho <luciano.coelho@intel.com>, cocci@systeme.lip6.fr,
        backports@vger.kernel.org
References: <deb8e4df52ce0baddcae77458a8a7246814b8804.camel@intel.com>
 <b417bf64-7970-8482-0246-ab00129b4657@users.sourceforge.net>
 <alpine.DEB.2.20.1808151127520.2309@hadrien>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <2bd2aee9-eaed-3c04-f5e6-f88ed43a337c@users.sourceforge.net> (sfid-20180816_074553_692200_1A519586)
Date: Thu, 16 Aug 2018 07:45:34 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1808151127520.2309@hadrien>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

> This is rejected by the semantic patch parser.

The software version “Coccinelle 1.0.7-00472-g99fc302b” accepts the following
SmPL script variant.

@replacement@
attribute name __genl_const;
@@
-const
+__genl_const
 struct
(genl_multicast_group
|genl_ops
)


Would it be nice if such a transformation approach can work also without
the specified metavariable?
https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/tree/patches/0027-genl-const/genl-const.cocci?id=694b78f1533eb72c638c83754e0567630a93f456

Regards,
Markus
--
To unsubscribe from this list: send the line "unsubscribe backports" in
