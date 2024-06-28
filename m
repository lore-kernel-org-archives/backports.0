Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37B481D7
	for <backports@vger.kernel.org>; Fri, 28 Jun 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571826; cv=none; b=ngFHqKSwaU4j+K7UZiWUjrX8wCMUUfh22cj03qdvWeKdnU+6SMmA3bgv621pKVdMv2jxpAWMgJdAKabj66EfuZ0OmmyOcOFt1JMCVbZGgmtR07PsaqZcc2Kla9IDFqvLIHqOoj2yKs4tpMPa+Unc4alKRYUuvr88Pqcd7hZFavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571826; c=relaxed/simple;
	bh=X2NAwlSYwXzlnLdWlwzHW6Hma259e8R9k4K+/V6rN98=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lJ6slCQaAvOySUwJnruwHrSouBSRqe4TnRLi7Uz8fKW+o+eap8JOFXoc1SDN6l3eaxfER5Jr4GBYfZDber6Hp8g9SsDLXONPu6r2ksJuEMPinIeIGSGNJTFVeA+BNJsFWtz7WGeGLQBgVUeXci72I9MHTzPQ5fdX3uoLbRG9BGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=by5nm9WY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="by5nm9WY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=X2NAwlSYwXzlnLdWlwzHW6Hma259e8R9k4K+/V6rN98=;
	t=1719571824; x=1720781424; b=by5nm9WYO+rTV+rJLBwyxegXW/qri+CoFYRo+LjCPhAVQ/t
	QYEn0GilnlAO+v9M1jT98MveJi0aYN5b+/cM7ynFilSwRSDte33yqPoKuymgz71uQAvrQvtPtCPQM
	cMXAjwI9t0/wkcYhPa4+F2uDVqmdoBle+m7CulYF7BDMBJvW8+LKEg+uItZldpN3bKvrCbJzH2D+I
	iiIRSew/8FbOfYVxVnbAwLPqOvboJ9GNL8jwCz83DiAUxtAJ5mkNextq/M0PeACl/O5XLXARKYEP8
	StSQj5vwz6Wo4P13hCv2ClhF7w0mznmk2pVf+g2bbH7lvUlXGsVltN9o24xpqQCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sN9BL-00000009qNr-1kmu;
	Fri, 28 Jun 2024 12:50:19 +0200
Message-ID: <9b8eb7b9b5790b2eac74b5f22efadc67de72a69a.camel@sipsolutions.net>
Subject: Re: [PATCH 61/75] dependencies: Make CONFIG_R8188EU depend on 5.10
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Fri, 28 Jun 2024 12:50:18 +0200
In-Reply-To: <20240627234808.1253337-62-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
	 <20240627234808.1253337-62-hauke@hauke-m.de>
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
> CONFIG_R8188EU uses CONFIG_R8188EU()
>=20

copy/paste mistake?

