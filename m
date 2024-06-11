Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496046525
	for <backports@vger.kernel.org>; Tue, 11 Jun 2024 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104422; cv=none; b=g11lC7QxUegUorXu7Vx52VyjjADn+co9r/am4fJfwbdKP78aloIuB8Q7B1PUBP9fppcjrf8E2Bea9C+SDUKpLUc/HKD81HpPymhz5GcWFsBjbKFMzYrr7FCYtGpuLS2w0RHCD/xuhaKLewauv3sY4Qn49eclDv51G/BX94sTr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104422; c=relaxed/simple;
	bh=J07XnIWDJhf07hyBCS4TYiUfnBKbLwkl5eXToJcE2l4=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=J0hThVmw1+3PIt/5A1lj590VfEp8hYEQzSjzQQyG3uaPGO/BhB8W/gaHBA27uTxNkN+pgYRKLcQcXncLBr8gWS7ibcqv9QXIyiwuWRKIdI8ufEGawQB9WlHRol3Kh28+MxQfuTp8G9icGmRdcVvt3l5BcjmnCMI1szMkk44R2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uLNB09GZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uLNB09GZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=J07XnIWDJhf07hyBCS4TYiUfnBKbLwkl5eXToJcE2l4=; t=1718104419; x=1719314019; 
	b=uLNB09GZnxeokEag91jzSpSTKq57GiqfLFG2RAToItWqm3HiVGSv4gYtEQ2egYKL4rouynZRZjZ
	tqhm55AunhMz7hLNS6UU60QObifuvIkpYUuLDfj4zLqmllyPX3LrcX8czx8N21ewUpGRIEp1zBDSL
	4i8tUc7NHdq4y+ZhJ2t5/YwjpHl0pa93y+xSDBpv0capi9IXny5LnF6CLPJTEUZkLb3jATyUX3IP3
	Uvizey9ljKzj5/ewM0kgJGAVdHc/wSH4IQzAgwzwEZ/YM1JUNw92Fqlf2GcO1XbOS4TmcnDgj5eMW
	J/1lpWks7oeWBQUhxN4VJiWXih2UvQK1WIvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sGzRY-00000008WUx-32bG
	for backports@vger.kernel.org;
	Tue, 11 Jun 2024 13:13:36 +0200
Message-ID: <8f050618afa00296db53d752db334eb7dfc5ff33.camel@sipsolutions.net>
Subject: __assign_str handling
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Tue, 11 Jun 2024 13:13:36 +0200
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

In 6.10, the tracing __assign_str() macro lots its second argument.

We simply made a patch (for cfg80211, mac80211 and iwlwifi) to put it
back under ifdef, but maybe someone else has any other ideas?

The big problem is that it's defined/undefined/redefined, so can't even
override it (if it were even possible, since we don't generally know
what the argument should be).

johannes
