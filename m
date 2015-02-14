Return-path: <backports-owner@vger.kernel.org>
Received: from mail2.candelatech.com ([208.74.158.173]:59275 "EHLO
	mail2.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbbBNAcr (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 13 Feb 2015 19:32:47 -0500
Received: from [192.168.100.236] (unknown [50.251.239.81])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail2.candelatech.com (Postfix) with ESMTPSA id 8AD3440EA33
	for <backports@vger.kernel.org>; Fri, 13 Feb 2015 16:27:44 -0800 (PST)
Message-ID: <54DE9680.5090900@candelatech.com> (sfid-20150214_013249_911229_DCB524AF)
Date: Fri, 13 Feb 2015 16:27:44 -0800
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
To: backports@vger.kernel.org
Subject: What distribution supports recent-enough spatch for backports project?
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

It seems Fedora-21 has packages that are tool old, and I had very poor
luck trying to build coccinelle, ocaml and all the other dependencies
from source.

So, if there is a distribution that just works, please let me know.

My goal is to generate backports builds based on my own modified
3.17 and 3.19 kernels.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

