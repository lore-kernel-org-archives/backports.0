Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310D2139A8
	for <backports@vger.kernel.org>; Fri, 28 Jun 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571731; cv=none; b=mTNec9TdUId0ru8zEVOZYk444pV/chnbUWwmIvk3zvwh2NepZINiBKLlu4RTJoc3CTeNxQuz7VPKtw1vYhLiE8JegeFWQG/vQLehUhgho6FlNcKBHgbESYdjrUcC1gHW4M1/bVVtL1J7oKP5EY6V5h3vkgi9ofHbs+6B0MHpqO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571731; c=relaxed/simple;
	bh=Vcd+WHS+OSmAdl/mdVUQAxehnSI9CySBJQokuKQx418=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=emzc/QzPDmROqcQKQjmhaIJvXbTPJJUl81SXFI04lM9MY1Eo+HN1JxVvni3tQfR+P97rCX+ltQ5sEjbiVKrrG0zwPIhPciBsERYePzqnJPw/0lnDqez31WzslDTJluDhTN21rlkTTk0SRBQRsRrWXdnSi+vSduZuBT5kwWjFA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VzNYUmfk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VzNYUmfk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Vcd+WHS+OSmAdl/mdVUQAxehnSI9CySBJQokuKQx418=;
	t=1719571730; x=1720781330; b=VzNYUmfklNIFVghw3hbc/lMtZ+wmFc/9unISakYEu/EUgnF
	m4r4ssJa56UeB/EkeiRyK/z6gKlU9bbz/gRdIisc4UN19nA2+PEe2U6I70ACMdUGfGD5h7Zco4dv+
	nKWCyh+pQLb3KhVX8uhEwGhD2L3Nhf3Fb6OUjqu376nHF++ZBvMgbNz4XyifjqyxObB9CcsBrpejG
	b8eeD/QJmky+DNlpUrQI2DUEYsJ/VRh5VtJVj5YpEpg28Y7Zwa60tym7qkpMNWRVZCBCnN3syaVUB
	vd6rJ3EehFJR8p63t76IvA7O1CiqY4+MO1lxv9v8WrBE+ZE3F4kD+xIp76+7DlSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sN99q-00000009q1q-3x3h;
	Fri, 28 Jun 2024 12:48:47 +0200
Message-ID: <2b1f167aa1a4f75f464cf5083d06dcbc719b0af1.camel@sipsolutions.net>
Subject: Re: [PATCH 54/75] patch: bcma: Fill of_node instead of fwnode on
 older kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Fri, 28 Jun 2024 12:48:44 +0200
In-Reply-To: <20240627234808.1253337-55-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
	 <20240627234808.1253337-55-hauke@hauke-m.de>
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
> Older kernel versions do not have the fwnode attribute in the struct
> gpio_chip, fill the of_node attribuet instead.

type 'attribute'

seems this should've been fairlyh simple with spatch?

johannes


