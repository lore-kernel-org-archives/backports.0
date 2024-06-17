Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0516630A
	for <backports@vger.kernel.org>; Mon, 17 Jun 2024 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643510; cv=none; b=QzAw7iZxogLaJj1hrk1RoExPfGlMceFI78vsDiyKgG4p0WAPYTITXxUgdyxSqkFSgdUiTwdEqmM6Fg0Pd37dYtaKV+uNzC3XOwlcBOx6Q/mzVQVInheIpKoG88Z5BEFHi4DcRRWGipyVILJVxQ2MZWfTOPGZEguTSqGuO21jNFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643510; c=relaxed/simple;
	bh=0TCVxIp32ZJ5KJuShrY2GSdiqRVvnM1yTjrCgX4A/Gk=;
	h=Message-ID:From:In-Reply-To:Cc:To:Subject:Date; b=FgfyhIKpm1KcU8Rswp/rvGv0vqP7FQZJFRmmHzolF5+eExy9OXvoeo0sxKuoy0vfEdwM+m6YtWnZzLiQpoWMI89KVoGUnAwCP8GL9qEwvZ6VlqpJbVWamB1TW8HwdMYqZ6OsL/gJ9fw9BELeowoacG+KmK43CntP4LCFHb1A9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qWXV53iB; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qWXV53iB"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W2x0b3NbSz9sSk;
	Mon, 17 Jun 2024 18:58:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1718643503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to;
	bh=Se9BhppgwNqIsHiC+Tfsr5ljm0zzEjgUwqyIld8hfPU=;
	b=qWXV53iBGbAoR/YXq0Ms6w7sDneUD3WaGRNLXsdsRZICi9ZNOSBlCP17dbzZM2hAEfZi0i
	NIFtzPLc9BSvJb/1cRb6r6NXGbbgZ9OWoCX+vqVt2x2ISgHLjS3F7aoReg7AMlmUfZPpml
	TjhQANgadQi/VPfowIxkagHc56Kg4ne/SMFrQ3hBWN2jpK8jfOHDTUi8yYZkEtT27Cv0Wq
	EWV0pZIwOPwePPbehzAAlKpuqT574XhR8pEUSCmcK7mUvxP7mddSGC/hd1eBSwHvHKiOF7
	/gVTgnGycbCFD+lkfZNGGcLG2KyJR/A1rw7UW2VwtgCDLOJEbbfbi8ZRJSOAtg==
Message-ID: <ece6b8d8d6a1c144126471c47db4be60.brian.witte@mailbox.org>
From: Brian Witte <brian.witte@mailbox.org>
In-Reply-To: <8f050618afa00296db53d752db334eb7dfc5ff33.camel@sipsolutions.net>
Cc: backports@vger.kernel.org
To: johannes@sipsolutions.net
Subject: Re: __assign_str handling
Date: Mon, 17 Jun 2024 11:53:48 -0500
X-MBO-RS-ID: 1798935b39380297874
X-MBO-RS-META: 3qx84hey7u8dfqf6by1yksg5uykdpamm
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>


Hi Johannes,

I am unsure here, but I looked at Steven's commit removing it:
2c92ca849fcc6ee7d0c358e9959abc9f58661aea

I was wondering if a variadic macro makes sense:
https://gcc.gnu.org/onlinedocs/cpp/Variadic-Macros.html

I don't know much about how they are used in kernel and searched the kernel's
src and came across your commit here:
568db7fd27fad183d186742dc7ae6ca211ba51ff

You introduced the IWL_FW_CHECK macro for the iwlwifi driver which seems to
handle additional logging parameters well.

Could we modify __assign_str to handle variadic inputs?

For example:

  #define __assign_str(dst, ...) __assign_str_helper(dst, ##__VA_ARGS__)

The helper function could resolve the assignment based on the count/context of
the arguments.

Fwiw, I am still familiarizing myself with kernel conventions and
backport-related modifications so perhaps this is a no-go.

Figured I'd share my thoughts since I have been running `gentree.py` again...

-- 
regards,
brian witte
