Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDD54DA0C
	for <backports@vger.kernel.org>; Fri, 28 Jun 2024 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571684; cv=none; b=e9ZkbSDpCI5Em7h8l/efI2Yl6PbYEVzJolZyTvaqVXYw2zJCy5MguGQrBjmfD9M7afsdqPcEAEkkoGZtya05o1KDTuor2vSSn/W1G/EcBL4qE5pFPKtua+Z+q9EPtw3oAuyOIgCFinRVPORznxGZ/mQ+Y/9N2cXbb07ih/Bx+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571684; c=relaxed/simple;
	bh=1H0OdWiSEgt2mKJKIFe1Ir1zwjOJbmTggEIYHkJuE1o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SPw1k+GV4Vo3XsKn5DY0xZtTBfOl9JS2TpAmmAv1IztV55AmaDd3z+ZVJQUgGJRfZBR0z90+3IgOaNFvyObYdF0PqKXrVN4zdXISGtFNxmPK3dr6M64gFsSzA9L6hoeTXCm+5jPeh9vvqQ4gxmwqbJK64HUpLUQfyvYMHsmOM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Wt1yyjFT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Wt1yyjFT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=k9uQDDQAYJkXJucBRbRCyNTkYKHv8a+YKPtV36Q7Vkg=;
	t=1719571683; x=1720781283; b=Wt1yyjFTr7Y4+Ri3ySmVVY+MCMhBOVMI5Hrsz/q6Sg/m/XW
	Dhv8f5JFrXyxJDpR0NLCE6Qijxa5UITD9mBxyOxOq7rdhpAk+TvQolPR4+g2wzKjsbBqJnH6MCW2y
	/SuxmDytekRHyMTKEAkXKKvfAWruJZ49svnQD0mfV3AAUTZugL8qQyv1h3Std2pfDi7KYvAOIyf93
	7756apnQQGCaAaLUfwMNd8nwX1rceeL5uYNPXWBOUVdJv+kxuHBWzUWcRAd9IL9TT8aaNHg3hERe3
	UpViHLhJv5TwuLcmBfmmZDaC6uU321ncscWhTq6j4OG9ysVaj5vpqxDsM9Lv0ukA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sN995-00000009prb-3CcX;
	Fri, 28 Jun 2024 12:48:00 +0200
Message-ID: <0ec11d2056890b47f93b74bc224351d5b9f25c40.camel@sipsolutions.net>
Subject: Re: [PATCH 53/75] patch: Adapt struct pcpu_sw_netstats change to
 u64_stats_t
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Fri, 28 Jun 2024 12:47:58 +0200
In-Reply-To: <20240627234808.1253337-54-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
	 <20240627234808.1253337-54-hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-06-28 at 01:47 +0200, Hauke Mehrtens wrote:
> ++#if LINUX_VERSION_IS_GEQ(6,0,0)
> +=C2=A0	u64_stats_inc(&stats64->rx_packets);
> +=C2=A0	u64_stats_add(&stats64->rx_bytes, skb->len);
> ++#else
> ++	stats64->rx_packets++;
> ++	stats64->rx_bytes +=3D skb->len;
> ++#endif

I suspect we _could_ do this with an auto-detect macro?

#if ... /* < 5.5 */
#define u64_stats_inc(v) (*v)++
#define u64_stats_add(v, a) (*v)+=3D(a)
#else
#define u64_stats_inc(v) \
 do {
	if (__builtin_types_compatible(typeof(v), *u64_stats_t)
		u64_stats_inc(v);
	else
		(*v)++;
 } while(0)


or so?

But then it's only one driver here ...

johannes
