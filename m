Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C735154BEA
	for <backports@vger.kernel.org>; Fri, 28 Jun 2024 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571380; cv=none; b=gkwXB1yFpkcYkAWhezdh+uG1G+/HA3cwQQ1jwUqezf0UxRE4+HxzRvXeI1SV/mOT7gWYQR7iP5DEohHYe0+p7/0dj2N09wBjTzL3+5gUN4P3Hb4CJ5LGdL3Fdizl6gmpwUa8dndTSozGYQuse4e5LGQ7AkFwLu9DPNoLgvmvRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571380; c=relaxed/simple;
	bh=vzLbz7KJfmERdDD0Vu7bNC4NUeBr+MCkyWhNd0eZEDA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d4NuUyrK/5WldcFukLrz+6NjE6X+Uik4TUQzKReK/magHaGwljGM3A3aPrsiIXk7ARf5nbx/c1wp4xg13Xcv0q3zn4piiD08KqiQpfUBiG6iP0JDr33lLzjaxKyZYz07Ojs2emdxjIsBOLYg+C3xp38lJRmcAGR0cr45z2JU4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YtGxiF3H; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YtGxiF3H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vzLbz7KJfmERdDD0Vu7bNC4NUeBr+MCkyWhNd0eZEDA=;
	t=1719571377; x=1720780977; b=YtGxiF3H40Il2S9SLGOJgte2OxVcPjOQ9CBmIE2/IZdQkBr
	w5z+eKjLZ2w0cD6igjCNGynjW40KwdIdpsZAniXhTy0CVZgLzlRQQSF66tIm5qWHidnibKbjgTNJl
	dopQeOxZbpnJ0HKdWeRckvCZkALSDKFyEx1P/oGlHvrvH0QIWwsxHiJOrm9Tk99n6E5A5IdVEa6qV
	qygXho6F3jtEjdyGDQIM1WxJTPmpR7yjCNK7u/29NOB3fsq5TVTXQavDHKbqPUkO7n5dQK5S3PgOx
	qEnSPfgq1T76wsLrJJ3I/pPdE4rBaXHGidOxNgS8sovgY1B3YPJmHm1QU3WwuoXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sN94A-00000009ou1-0ndD;
	Fri, 28 Jun 2024 12:42:54 +0200
Message-ID: <3e694916e936fb0ae8bcd8bd2fc51e611b51f352.camel@sipsolutions.net>
Subject: Re: [PATCH 48/75] dependencies: Make MHI_BUS_EP depend on 5.19
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Fri, 28 Jun 2024 12:42:53 +0200
In-Reply-To: <20240627234808.1253337-49-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
	 <20240627234808.1253337-49-hauke@hauke-m.de>
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
> The EP framework was added in 5.19 and the interface changed in kernel
> 6.1 again.

Subject is wrong :)

johannes
