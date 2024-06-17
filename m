Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA9316631F
	for <backports@vger.kernel.org>; Mon, 17 Jun 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643702; cv=none; b=GJSgw0FgGzPq7n6lvrEy2KlVr+IGoT6Vy+J6DdoLSumDovPoq1yJobofSkRweuwK+owuP4ixXQKOSkQ6AfdX8CAF86ThNwZVaLJ41Cu7gDNZnUzTVFqtoJvJkkhpGuu/LK41P2LUfx2GvsTsSvc7Pe1UZURMWbQ5R7OgEh+HJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643702; c=relaxed/simple;
	bh=abMs7NPZYrEdAJ0IGPWHlvQNZiTXR+ip3TkrZAeeq+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+dFGQdQt6CPmSFY/oxRrA61oNkQBAVlavHFNaz39bn5s59cwY7utiongJ/SgNvtZGeGciwMvgxzZJgcv1eqsKnNi3hnuN+Fe2MBL8nMwJSKfjcJumdAlmsEyLl1Go5qXFA8k+rLjlsz1f29E0axlcekO94UFofkx1Yu9WYsf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lvBy5zsS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lvBy5zsS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=abMs7NPZYrEdAJ0IGPWHlvQNZiTXR+ip3TkrZAeeq+c=;
	t=1718643699; x=1719853299; b=lvBy5zsS/N9R4kQYBqHDL8lQkYw6BfR/dfRV37HAR8EfSqP
	vTOWPuV5sPeEron8C4ZPCcmJxrG0EDJU4kjnudfqCG1mHAtTKk/UVsmdbJ/7Rjbid/GzbDdA5wDpm
	BqE8I/zwEPFp//DIwVOObWHKt0hDnQv9pfdGlsSCHSAAC5PpT3Hq+iEgy9Z5n3mEVAu5YgLBSgPQv
	jId9c9r4ud+QrMQ7tOg78QoIUsibTmgJMFdBqnBlF+Kpig6w0Q9Kv83gWm+6YXkRHTdcg3qDqhvbX
	T6FzG4yYhPfYywvRLJlvV88KdsMIhuZ3lEcdpS4ulcyhEhmd/2t83c1QVrNIMZLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sJFjV-00000003L6s-3Vhm;
	Mon, 17 Jun 2024 19:01:30 +0200
Message-ID: <642386515723f0de4b1628ce3d2d0338970db1dd.camel@sipsolutions.net>
Subject: Re: __assign_str handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Witte <brian.witte@mailbox.org>
Cc: backports@vger.kernel.org
Date: Mon, 17 Jun 2024 19:01:28 +0200
In-Reply-To: <ece6b8d8d6a1c144126471c47db4be60.brian.witte@mailbox.org>
References: <ece6b8d8d6a1c144126471c47db4be60.brian.witte@mailbox.org>
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

>=20
> Could we modify __assign_str to handle variadic inputs?

I think no, because __assign_str is actually redefined a few times
during the trace code construction.

johannes
