Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DAE158204
	for <backports@vger.kernel.org>; Fri, 31 May 2024 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161894; cv=none; b=Z2M3QYiBnvPc6mtcpJUU7wNi7GBy9ey0V1HouYG9PAbPqJ8xFBhdhOOqEGzQ9xImObKDPSquMgGiqMeKo9f/COHynkTFlAJ5Y5CqmKm4Bbcfq0f30ul74BDnZRbZkNHXwvHOifhLG9fA3t+726rib7/j0Fr4dq0BXXfPc5JUFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161894; c=relaxed/simple;
	bh=J7umDk4/KZ125eaJFzTDvEzADw0NAsxdUaoZrMEvl30=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sgdDsxWA7WDKuJe+9F5wQpFpGCrF31Ys4v92w9caOT0gKbKCedlxpwcbUm8rCb2Tm6+tK5WLYM0DiZCRUfGs6fRvDCPdnuWpgP5OrVBwcqW+Wvda+m5Lmd6Fft0/N+wB0NrP0KgwUawN8N2hH2fYGDZ4xuEOHwxklKef0eEDR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=BYzEhUh4; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="BYzEhUh4"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VrP3t4R6Xz9sp7;
	Fri, 31 May 2024 15:24:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1717161882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGKfsN0D4wULOhqzp1N4x7wflFv5g/ft9qsDjlELm50=;
	b=BYzEhUh48+0qG5fZLc4vMcH+qIncsq7n9wnSP0xVEBHlNYYEspVVVuNO0QCPqSS/krPiR7
	J6n28g/+bXC1Bhs5yLgWawJsLcMpu5r1sXJUNupEVt+HCob9FKQelh9/9mTeehe+q7iUF+
	HhV6dSERwyaBrmIdUoxq2N3PaA7vSlJot5IVNzqZy8sHOahKpopkzK2CJu9LH7gWcHnFrj
	s02UYy35bso2J0h8aLVexCaNt8Kt2URahjf1dsYfOcB+0IHQL/sZfXjc98SNcLssXcZRbW
	c2SrUBFLweW6rox//+gpHhPhrrLUaLMSVvNxp2C8lE1iP3INfCNoNbKZuWB2Dg==
Message-ID: <b1d956b3-4c1a-496e-a532-54727d4b2fb0@hauke-m.de>
Date: Fri, 31 May 2024 15:24:23 +0200
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 00/74] backport updates from Intel
To: Johannes Berg <johannes@sipsolutions.net>, backports@vger.kernel.org
References: <20240524170906.54680-76-johannes@sipsolutions.net>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20240524170906.54680-76-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4VrP3t4R6Xz9sp7

On 5/24/24 19:07, Johannes Berg wrote:
> So ... I talked to Brian today, and realized that we've been
> sort of maintaining backports to some extent, but not really.
> 
> This is what we have in our tree that's not upstream, and
> rebased onto upstream (commit c96f36d5214).
> 
> With the copy-list restricted to the iwlwifi driver and hwsim
> it even works, but the copy-list as-is doesn't even work, it
> even contains some files that no longer exist.
> 
> But it's a start, and it's a lot of stuff that's not upstream
> yet.
> 
> johannes
> 
> 
Hi Johannes,

Thank you for the patches.
OpenWrt still uses backports, I would like to get upstream up to date 
again.

I took some older patch series from you and some patches from Felix.
https://github.com/hauke/backports/commits/testing-6.1-rebase/
This is compiling fine using kerne 6.1 as a base.

I really should clean up the last patches and then push them to master. 
I haven't done much runtime testing, but it looks similar to the 
backports we use in OpenWrt against kernel 5.15.

Hauke
