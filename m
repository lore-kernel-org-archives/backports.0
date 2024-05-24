Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12651376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570561; cv=none; b=LR2hOGY1TT78tsjJyFOLZ7oqNihnOKC0peHYmPoPcTT5qdJWPYvfUZdeQvUHcH+jyufvpwOcxzdttIQTOfRkvkIoDWiWnnRlCIKoFfrQcquE7cH4+XeIQIk2ducOdgYBPAxioX+s7Vl5XID/TXjgPVmoE+DMFpQB8rSol7dWxDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570561; c=relaxed/simple;
	bh=TiBYIr4iPVJVWbCz2iMvyjZfurwlcpp8qrwxB1uK5io=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iVMcAZqs9kh3l3wn5DmnHaqXT2uPI5+PwMorDi6de6hh8+ljPoxQQTRKDRy+8+gU6DcK5Rpbhd5dfXXcjkZleULn5aGcmtt1LktBDfH2tpOr0p/K1gTEl49qG8dDH/5k52HGtK4d7xstZiQ/pD33B6unKb/7Put6Ul6DCBYYa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pJ8QUkfm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pJ8QUkfm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=TiBYIr4iPVJVWbCz2iMvyjZfurwlcpp8qrwxB1uK5io=; t=1716570559; x=1717780159; 
	b=pJ8QUkfmpjVhD00OHSImC3D8f/JpFj87B++Bx8axTzH2591D/HiwVysQf1Ht5m2lU4PTb3FGw77
	ie9XKA5mW7aab1yUWOH06OTSEySIeAisXp19+7Wq7FEZ1Byb//QQv1AcfUCJYEAd5Ur2jc4VT6s0K
	1W/DMV8GNvYeVDJZg5msyWVDJbLxb0FUc84sT6IWqmxWuBw06xAsRg1FoliVcFkEg+UZl/Cdlt8cF
	HEFvEd7qaU1hYZhJY8op6rUV9eAXG7b3461FHMFl2IvzoEmFkxEYaq5RrHdWLfu6n6S39lMFPVbPM
	t4sIXWJsRRXiheZTrpOmpsW50qtnp3C+MJVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPn-00000008Xuw-058v
	for backports@vger.kernel.org;
	Fri, 24 May 2024 19:09:11 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Subject: [PATCH 00/74] backport updates from Intel
Date: Fri, 24 May 2024 19:07:12 +0200
Message-ID: <20240524170906.54680-76-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So ... I talked to Brian today, and realized that we've been
sort of maintaining backports to some extent, but not really.

This is what we have in our tree that's not upstream, and
rebased onto upstream (commit c96f36d5214).

With the copy-list restricted to the iwlwifi driver and hwsim
it even works, but the copy-list as-is doesn't even work, it
even contains some files that no longer exist.

But it's a start, and it's a lot of stuff that's not upstream
yet.

johannes

