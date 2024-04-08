Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263BD8564E
	for <backports@vger.kernel.org>; Mon,  8 Apr 2024 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585725; cv=none; b=mdcslbNZ+872rnRjyXnEHBb4wU5WRlcST63yBCPnJd/2hlIKh4ffS4L4Wk8BACgkWJcQOnto/eB9iR8971Q0mXP80jChZJ1bA8326pBPyeIwJewJkUq4g29RLlIeU0sltSKb52+70oh3j81BNHnU2hpeG9jmWmaols2RM35v4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585725; c=relaxed/simple;
	bh=dqvXCU5lz++gI/YD7LmYzjZTQeDv+dFQWfzgL4viqrU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Twp+FBXg/pe6QRT3Jpshm8X+Y3tkFsRrOjTtjLwPcrrwMaU/hpFeTJxYF60oRQiX+zdZsX9mWXMtZnGIBobniiIphdiAFw+Mucpm/1tA/cqrk2R9Ve6NY+Q58fxJYmEDeRSefi4q1dWOdOJUqcWCG1i3sj7X5b4w4shZlpBj6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fJFsg9Iu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fJFsg9Iu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dqvXCU5lz++gI/YD7LmYzjZTQeDv+dFQWfzgL4viqrU=;
	t=1712585722; x=1713795322; b=fJFsg9IuBZWJOkxQdgXUWWxoxk81JrqxWwMS5HfgW45JPhS
	n+XqyZOa6Z6bKi5Awgc5mfcwMJVFc4wWIOzPTHRPYZ6fZU82OW0UJmLBuTbeaEzUGvxeHAZjCMIX6
	r8aQem7VOIpROcR55wHuFFZFe3PnHwt1Q65WwztZkbRRQC2rV3KYZbgpT7Q7ME7wKQv1xjaqN+K1c
	zSAZwExK3GLQ5CHnOsOss6mhjeCBm1zShjX6cs2wnkevJ+HGv7ahzjR+5iZvosMEkHPP6VcNJmVMw
	hRtMqsKTjFcAAlXZnAsS8luAI1DAgOLPPbzqfo7N9aAgLCUkv8ajechTZU7ZXvqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rtpmJ-0000000GIir-1r3r;
	Mon, 08 Apr 2024 16:15:19 +0200
Message-ID: <a321cd180adf72a3e20ec316f3385862b132336c.camel@sipsolutions.net>
Subject: Re: [PATCH 00/10] backports: Remove support for kernel older than
 4.14
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Mon, 08 Apr 2024 16:15:18 +0200
In-Reply-To: <14f53b97c5b03fe86e217158dc42407cdbcd04ff.camel@sipsolutions.net>
References: <20240401220314.2434455-1-hauke@hauke-m.de>
	 <14f53b97c5b03fe86e217158dc42407cdbcd04ff.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-04-08 at 15:49 +0200, Johannes Berg wrote:
> On Tue, 2024-04-02 at 00:03 +0200, Hauke Mehrtens wrote:
> > Remove support for older kernel versions to make maintenance of backpor=
ts easier in
> > the future.
> >=20
>=20
> No objections, I think (**), but why not also remove 4.15-4.18 since the
> oldest stable kernel is 4.19.x now? Seems there'd be little value in
> those then.

Oh wait, I misread, you're keeping 4.14 which was previously still
released as a stable kernel, so I guess never mind.

johannes
