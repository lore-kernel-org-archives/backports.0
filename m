Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95911E04A0
	for <backports@vger.kernel.org>; Tue,  8 Oct 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416403; cv=none; b=JMd709DDXgSeNKqk/aCI1zpTyBGCEGI43kVSGfJlf9SZrgRq8o5szygyPhntE6kCXITayNHkF6wK1TGfEWdshu2YaMjf7gC3nLiFa+Mf0RYNsutmXsM44FPizcEFiUD97r3ENFuu5SjqWdDneF7X56QqDoVQvNQEs5steJZgGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416403; c=relaxed/simple;
	bh=2xlD4fpjjy7cx11ZgGw6GYvelkd8/95mjL9UcKQZRlk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CFpaDu1wEiosXWWERux1pmvbYfSUrCOVxUghHVQc3YuoCf1XzKk3rJm5gMO5owD1BlMoP+0zO+AiShm4M+HRWG3T33UBiJG/AC5Syl2WtngVFnITqfnaiaMWkURBkMJtr+6EMgmLGxHY6cGxZHuqL8bNy143S33ttTQxtf8qOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hPW+Bsca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hPW+Bsca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392D1C4CEC7;
	Tue,  8 Oct 2024 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728416402;
	bh=2xlD4fpjjy7cx11ZgGw6GYvelkd8/95mjL9UcKQZRlk=;
	h=Date:From:To:Subject:From;
	b=hPW+BscaZdFzylRLkWyQh5TCQ/TlLEmg4QHEr12l3A56g0WTPToiFx81thvHwDRl6
	 fKkqCfF2c9MsepBZZCY3y1bii0aOcUacUeQG6A8ywQd75s/7Refq0dAObBxpPq3TJ0
	 WJ15PW668FNkVcNIR7FwvqpyxNY6u3imyfA1KXJs=
Date: Tue, 8 Oct 2024 15:39:53 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: backports@vger.kernel.org
Subject: Sunsetting backports.wiki.kernel.org
Message-ID: <20241008-amethyst-kestrel-of-realization-bb7b26@lemur>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

We are getting rid of all mediawikis and replacing them either with archived
sites, or RTD-style documentation. The backports wiki was mostly outdated
information, but it appeared to be still maintained to some degree, so we're
converting it to a RTD-style site.

# Initial conversion

I've done the initial conversion and the preliminary results can be viewed
here:

https://www.kernel.org/doc/projects/backports/

The underlying git repository is here:

https://git.kernel.org/pub/scm/docs/docsko/backports.git/

It actually contains most of the wiki history as well.

# What happens next?

There are two ways forward:

1. You can clone that git repository and host it on github. This would allow
   for a quick readthedocs.org integration and allow you to edit the files
   directly via the github interface. This is a very wiki-like workflow and
   would allow you to grant access to the repository to anyone with a github
   account, plus accept pull requests with modifications. Once you have
   readthedocs.org integration working, we can configure it to be under the
   docs.kernel.org domain, which will allow you to remove the ads from the
   site.

2. Continue to host it in the current location and accept edits via patches
   sent to this mailing list.

Please let me know how you would like to proceed. If I don't hear back from
anyone in the next few days, I will configure the backports.docs.kernel.org
with the current converted contents and redirect backports.wiki.kernel.org
there.

Best regards,
-K
