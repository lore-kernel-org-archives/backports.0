Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424C84D14
	for <backports@vger.kernel.org>; Mon,  8 Apr 2024 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585538; cv=none; b=DU59U91nYOizaDrS/qr70k95Cihgd1c062crevV6zdIgKRrH+tCPaNVWXwJdR2kzSNkwXhAoocI2CmhAO22cqYkolDgRRBUwkuhWF6lp5WPvgIH3xmISFssBUABd9f5Zaz2j5G7laq0mPhs+e2hwif/l2WY3Ib1aLEMzF6X5XoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585538; c=relaxed/simple;
	bh=odF+m6iNtmtLXWkerEzBoumIWx4hgye/kKsNd4TB2mI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FqBI2t04kSZw/rDoG0x1zJEujmGfrJl+ngFMtaL2AISBCb4XRxpsSn3xidZuiIqRluWq2pMPyLZLYujqkVJR1D/Arhp2lOORpDPbIMwzD5ZBWpQhqZtQ1cjgcUNfBixSSBNv/E0OLhQTfWdnhmB4bKS/Wwm4DNeOptp8/br0omI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RyttH2dI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RyttH2dI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=odF+m6iNtmtLXWkerEzBoumIWx4hgye/kKsNd4TB2mI=;
	t=1712585533; x=1713795133; b=RyttH2dIKEfCiQ+PvT29IfGcjGkbL8VdCR2lKBpZC/V+jWw
	Y9SidMOEZl98KmmhJuXQqWjFf+9fgdEbKMzzSqYUVa2IJFRJH9/Oac2N4aqSUFqonZ9cpFhUPQP01
	kCxpq5pWAVhjIT2Hl4niyjbZygJKzuQgGiqjUoaGuTCzRczeI+zFc66MQITvqZdJ40ngb1dI632Fo
	lT0mLFc77sCeEAsnKb1iUxGQ9R+bYQ0LhxETXgY3LIze4bdyJgvcdrSLO7HQPi6wyHHbO4zzyloqo
	2YIRLkx7uxwy2SdWMoEL3v1VBM7XyaA4ucuffQ5GmWmGS6DMQN0ApYPTb9TWqL0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rtpNN-0000000GHzh-3V5E;
	Mon, 08 Apr 2024 15:49:34 +0200
Message-ID: <14f53b97c5b03fe86e217158dc42407cdbcd04ff.camel@sipsolutions.net>
Subject: Re: [PATCH 00/10] backports: Remove support for kernel older than
 4.14
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Mon, 08 Apr 2024 15:49:32 +0200
In-Reply-To: <20240401220314.2434455-1-hauke@hauke-m.de>
References: <20240401220314.2434455-1-hauke@hauke-m.de>
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

On Tue, 2024-04-02 at 00:03 +0200, Hauke Mehrtens wrote:
> Remove support for older kernel versions to make maintenance of backports=
 easier in
> the future.
>=20

No objections, I think (**), but why not also remove 4.15-4.18 since the
oldest stable kernel is 4.19.x now? Seems there'd be little value in
those then.

(**) checking internally if we still have a need for any, but in that
case we can maintain it anyway

johannes
