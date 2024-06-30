Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B526547A66
	for <backports@vger.kernel.org>; Sun, 30 Jun 2024 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719781080; cv=none; b=WxnX2o0Ex83dXQXa/dfF6IK4xYAYEsQYDggiaMRkiFLeLrLNRJqser2T+00ayHsut0HToODXIZ2r7eJI39vaB4KjKdW3BQwq2nsJNOvglEyKwhSuG+BsroM0+RMQqoO/RXl27OF0mQU6fgOsmpujEFyjcYl/K6Cs5S0YLrzvkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719781080; c=relaxed/simple;
	bh=30Vlxsz9nip0eLUUFMDC90LTqBhcxaJrKmbf4tslL9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h73tiMr5sRnSSl+6rQqrVCdMyuXRJeQ2KWhUbJz652vG7OCQHh7ZHyu7/DURQQxBvRwjgiPylzz8yQoFcl6p7olpOPKm0sek6OSqoSI2sxfiYmVWJv1u4TSsbcpxcQtzT/UQnH9IWEy6J1lxY7TSmPIWvjrWaWv0a77e10Ntyxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=AFj29zWw; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="AFj29zWw"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WC1hq72PPz9sWQ;
	Sun, 30 Jun 2024 22:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719781068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1H0rJe6PG4M2UXnIK3hY/0/Iu5lArXHc/jdNjj3FEw=;
	b=AFj29zWwO1BAphIevFlARtLpLx8Gt5Zfkjm58lu9JRLH1shdVrBh2RmCq55ep27bIBMc0N
	+tS2jr66pWDDqVTO34i72dLRoRuWph2X2HnEf+E57p4ZowLDUt2i9GN2oH8yNGpvSpGgL0
	I21GD8+Wo5Mn5T5obXSbNr1O7jfnwxmeuOrlp1ER/MPjf2+jTpPgJaTuZVhUhjLzx22HVm
	LjaLIEtpwNkWRhTDqIGF5kCCxYphi0zuV8+9ehjb3/zLRWAt7CUci9GwB/768atvvVl9ft
	9s4E6jA7Jncson6y9T7UwQaxFt1szZcK5IDCop6YGWF0PCMbY0wiWS/YUQ9wEg==
Message-ID: <89463d54-f66d-4bfc-9308-e1765e1dc91a@hauke-m.de>
Date: Sun, 30 Jun 2024 22:57:47 +0200
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 54/75] patch: bcma: Fill of_node instead of fwnode on
 older kernel
To: Johannes Berg <johannes@sipsolutions.net>, backports@vger.kernel.org
References: <20240627234808.1253337-1-hauke@hauke-m.de>
 <20240627234808.1253337-55-hauke@hauke-m.de>
 <2b1f167aa1a4f75f464cf5083d06dcbc719b0af1.camel@sipsolutions.net>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <2b1f167aa1a4f75f464cf5083d06dcbc719b0af1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4WC1hq72PPz9sWQ

On 6/28/24 12:48, Johannes Berg wrote:
> On Fri, 2024-06-28 at 01:47 +0200, Hauke Mehrtens wrote:
>> Older kernel versions do not have the fwnode attribute in the struct
>> gpio_chip, fill the of_node attribuet instead.
> 
> type 'attribute'

Fixed

> seems this should've been fairlyh simple with spatch?

I have only seen this problem once and will go with the normal patch.

Maybe we can remove bcma and ssb completely from backports and just use 
the in kernel version in the future. There is not much activity on bcma 
and ssb any more and the interface to the wifi drivers is pretty stable.

Hauke
