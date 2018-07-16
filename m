Return-path: <backports-owner@vger.kernel.org>
Received: from mail2.candelatech.com ([208.74.158.173]:40912 "EHLO
        mail2.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeGPSRe (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 16 Jul 2018 14:17:34 -0400
Received: from [192.168.100.149] (firewall.candelatech.com [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail2.candelatech.com (Postfix) with ESMTPSA id 59CBA40A5A2
        for <backports@vger.kernel.org>; Mon, 16 Jul 2018 10:49:04 -0700 (PDT)
To: backports@vger.kernel.org
From: Ben Greear <greearb@candelatech.com>
Subject: What distro can run recent backports?
Message-ID: <1ea772b3-612a-aa1e-8088-069864dc0920@candelatech.com> (sfid-20180716_194913_613717_B65B5B73)
Date: Mon, 16 Jul 2018 10:49:04 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

I'm trying to make backports work with my 4.16-ct kernel.  I tried Fedora-27, but it has
some bug relate to spatch so it cannot run there.

And just now I tried Ubuntu 18.  On it, spatch version is too old, and when I try to
compile coccinelle from git, it fails with an error like this:

File "parsing_c/includes.ml", line 159, characters 9-22:
Error: Unbound module Parmap

So, what does it actually take to run backports successfully?  What distro do you
guys use?  Anything work out of the box?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

--
To unsubscribe from this list: send the line "unsubscribe backports" in
