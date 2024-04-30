Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539863611A
	for <backports@vger.kernel.org>; Tue, 30 Apr 2024 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461478; cv=none; b=Z2phmvbtNoKGGJVvPGHdx5rfVdMr2e1cUKdovhXg2BZKb0N6jLJZRaqUiKyMxQfOlnPA/jVboCY8M7KW0PzA3tCq4TBB9WRmM/QQNm8E77u9TkUvx8BG2D8/g12dl7i4pxSaXu/0EapYwRfV5STB0xGaMN+56suuwuNXWQzkiKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461478; c=relaxed/simple;
	bh=NHDjZmek2ijHKOqcnci0kv/VIRGEUfIu+8C1mILytdI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMUMfHQi8DauVC8P3lD45lxl/0BaWTa7xOya23E4XQEGK7qAoyj4waWVz3k1N+yX0VhPVRfoqQAxcuESG3XVPeAi3FnnjpORrTErvytx6HWMWN5NYWDtzwN3ejbcPQDjPvJx22exrtRdZ6mSeNCIKlF6xsQLiRnu35WIlHo86qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CG0JBP2I; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CG0JBP2I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NHDjZmek2ijHKOqcnci0kv/VIRGEUfIu+8C1mILytdI=;
	t=1714461473; x=1715671073; b=CG0JBP2IkQzGcpCg9oTuHia4KvNFmp5zwbuEVx3EQhRkxEt
	htG2O/4weidJLRkofJDTJ8fzIOS5gfzh5/8CFqJBHAvf0LeDuPMp4w/yKmuoHdmh8iyUEMqFFUJXi
	EC6aGctPzKXWglO6bkxKGeeKthfJvW6kOhoiIf/k9W7j9UB03nTq7vxlkyhzECN7BPWuecO3lo949
	FgBaFB6Lh4Zt45FZjE/ZeWGBTY0WPXzr/ihPFlapP9i9Oy9UhLKi6C8WHfBOVwyCXiBuaFhh4+f0y
	56m8eivrYudsn4nBojrSG4ewlPpFemWVdvuxko0povyaO9YK7cvP5GWNqwxicpiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s1hkJ-0000000DzhE-2iU2;
	Tue, 30 Apr 2024 09:17:47 +0200
Message-ID: <af95705a8fa094cb75c9cd08008f6197bda37f18.camel@sipsolutions.net>
Subject: Re: backports commits without Signed-off-by line
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Tue, 30 Apr 2024 09:17:46 +0200
In-Reply-To: <6848cf78-1421-4299-8513-c7fe4cad44ce@hauke-m.de>
References: <6848cf78-1421-4299-8513-c7fe4cad44ce@hauke-m.de>
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

On Tue, 2024-04-30 at 00:57 +0200, Hauke Mehrtens wrote:
> Hi,
>=20
> I just noticed that I pushed some commits to master without a=20
> Signed-off-by line by me. Should I ignore it or force push an update=20
> with a Signed-off-by?
>=20

It doesn't look like we've merged that part yet so I don't think it
matters for us, but I'd also say it doesn't matter, especially since
those commits were just removing things?

I'd say leave it.

johannes
