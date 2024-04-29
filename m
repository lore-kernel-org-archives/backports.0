Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50BF1E888
	for <backports@vger.kernel.org>; Mon, 29 Apr 2024 22:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431450; cv=none; b=N5tjf1c11mm5lCnPt2K8Ne8pjKAvwq8/6t6qjPqM++8YdHimB0RNFAY/Jj165LedI7GX6sMVzHOpOYO9bN7G5FIzSffeGPAMCpBbTzWXdtOjcZE5WObrIc+yVDnNfLp1rmnw57FsefUkOUh9wrgKqz20aN8nSZjGKVOKDMZog+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431450; c=relaxed/simple;
	bh=p7WWz6VsSrQfP29lZjcLtioidXkge1iURyh2gN96coY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Ic3vIgd9l4g+6Idf5qjs9kqT7Gt9dXeJPxU7hB0R2mi675lU6D+EoXg1R6Jm+RLYLFxR1LCDeLX5CpQdu9dNvRjEZuJTA6Qd1EnJbA6Z1c2OHRMajY97qyp74CeepEylpV8vruKnAl7ky2o5JMMmOTgiU+bq/WK0ndDTBl/OUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Ypy+tR6U; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Ypy+tR6U"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VSzHS01j1z9tJ8;
	Tue, 30 Apr 2024 00:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1714431444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WPpIac9MnT07FmIJ7iRuK/xOiESG/vpqpgRcXVtoaTk=;
	b=Ypy+tR6ULw2bk/HnlFFNbAWtF3qUqB5fytGWHvpQhKlIh8SzoGtPEuQRBx+luF7DLUVZqX
	m7EjadjgHHElG4VS+Yd3K/mNWi/FZn/4O0aj0Vpf7ZPrvctes8I71tMF8mOI5hCXkoVabx
	TgbA7YL06Bhl8H+U6KIrw3+hmTZARX3fvA8BCY3wW5z/3R4Psdws40tDHJz4kVZDRUCS53
	pEAt5Jm2J4D5Axq9Qp2OehfE9zP6xaT7/L1oNVhg/NWLD81McjcZECIxUWzpDcOfOhFLaC
	cH2rgoT6yv29mTlBqeaP9HUC6cq6IhWxKCVNY0cqKaNlT1qtza3IKiilHBjGjw==
Message-ID: <6848cf78-1421-4299-8513-c7fe4cad44ce@hauke-m.de>
Date: Tue, 30 Apr 2024 00:57:23 +0200
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: backports@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: backports commits without Signed-off-by line
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I just noticed that I pushed some commits to master without a 
Signed-off-by line by me. Should I ignore it or force push an update 
with a Signed-off-by?

Hauke
