Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714FC21730E
	for <backports@vger.kernel.org>; Fri, 11 Oct 2024 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648105; cv=none; b=UwLyHBUUVQIw8d0Y8Vrpwq4vZRNVRnSdyx3cmcqYNHSCZjxm6/T6QaTdeWrYp4CYO4xN44M02MFDO/204Jwau/lpfpUIQVb95FshIm6S8+pfCjKCNbrbGWRdHUr822kB3arJ7SY1yKL3KyJwOqiifTdITQIFTAa9ryN2WFg7JSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648105; c=relaxed/simple;
	bh=CllwSRd/IpSg/DVqWYtDi8XyIAq0PVsXZummYuz6vgQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MrP9BE/423C6bzPnamcbk/5s0J4zsVTw0SdWazZvSJBa4P7dlef6gsTeV3upVh71HMT14LZiGbVdHDnew8Tyu0dh69A9jyLe5AcAOTBGoIXUqMwAvx1ZLGPw4AOp43TQDhICvHGJiZ3KrnowMSU+V7N4Zp3TADl+oMFjeRyp7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OBEkWuHu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OBEkWuHu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LEtorgSTn6cwcZlxykvV4uxv8L18LG/GiRkUoEL2qcg=;
	t=1728648104; x=1729857704; b=OBEkWuHuC0s6+jcAs3oicRLol+WzmSPxhpQvu/x3HfuYz4N
	LdfnP7QrxMv3iECCGIoQqXArvxfKItmUZ2T8exJG4Na0DKWac6Tk7relyGtQli7n1sh6yg4MdDKR/
	g0xsXPEuJqeCdJjFwJzh1o/04CACoHpM2jJ87Lpj0akmffoFtjkWFuoctBBdRMj4VogBnRyISAptj
	IaM5AZjL24TaAG42fE+NtBI6AFl6hRylRJZVLzEQCWVjCrXVRZjs2xDsDN3Hg2CLN4xOk/OimrLDy
	cXHRhJ7paxs63jug0AmfZNRMKWveLA0Hps9IAqEtKhSNzBPNMuuJks7M83OqkfFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1szEKz-00000007AYI-3MOg;
	Fri, 11 Oct 2024 14:01:41 +0200
Message-ID: <fc1c1d078cc5026a829d9c9daa59f6732add8520.camel@sipsolutions.net>
Subject: Re: Sunsetting backports.wiki.kernel.org
From: Johannes Berg <johannes@sipsolutions.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	backports@vger.kernel.org
Date: Fri, 11 Oct 2024 14:01:41 +0200
In-Reply-To: <20241008-amethyst-kestrel-of-realization-bb7b26@lemur>
References: <20241008-amethyst-kestrel-of-realization-bb7b26@lemur>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> There are two ways forward:
>=20
> 1. You can clone that git repository and host it on github. This would al=
low
>    for a quick readthedocs.org integration and allow you to edit the file=
s
>    directly via the github interface. This is a very wiki-like workflow a=
nd
>    would allow you to grant access to the repository to anyone with a git=
hub
>    account, plus accept pull requests with modifications. Once you have
>    readthedocs.org integration working, we can configure it to be under t=
he
>    docs.kernel.org domain, which will allow you to remove the ads from th=
e
>    site.
>=20
> 2. Continue to host it in the current location and accept edits via patch=
es
>    sent to this mailing list.
>=20
> Please let me know how you would like to proceed. If I don't hear back fr=
om
> anyone in the next few days, I will configure the backports.docs.kernel.o=
rg
> with the current converted contents and redirect backports.wiki.kernel.or=
g
> there.

Maybe for now it'd make sense to move the repo into the backports/ group
on kernel.org? Or are you trying keep everything together in
docs/docsko/?

It probably doesn't matter anyway, I'm just not sure how permissions
would work if it's in docs/docsko/, I guess you can still give the
backport group access? Who actually does have access to the repo now?

Honestly, I have very little opinion on this - even the few changes that
backports is still seeing we're not taking much care of the wiki these
days. Maybe Hauke has any further thoughts.

johahnnes
