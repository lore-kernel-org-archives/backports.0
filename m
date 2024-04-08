Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF27E8
	for <backports@vger.kernel.org>; Mon,  8 Apr 2024 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615524; cv=none; b=VCCZLTb+Jqy3lDCJ5Z/LwfcCWqpUNqjRRHW3Ug63oUGVLtl/PdCYrMo9/FRuveANA/04FC9vLbGAtF9NIv3V+5nzxX/Ml20kPA86r19feBZUXP/wA8PaChuu/kaTvYJExsG2AkfwPlN3jbYR1mLzkVjD0VNLGBZ9umhfrWCU61s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615524; c=relaxed/simple;
	bh=1kkcvx0VUL3HfiP/SNCDoqsTJaLHBM6x4aJERWdM9J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PTIX+UNAClgRO5WCispN/mpzY9p7MaGDy9sEYAUMy2okdzAMFyWyUjCrX1/Pj8845Cvr56G972iilZNREfZVEQKOR7/FTm0GjyIxmxc325kvllHbFY5g3x3xSEzfLVh5lgthTgPxsEK2+vnrXS9WhOHr/y6d0PSH3GwhKnTaSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=fnjQget8; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="fnjQget8"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VD3jh5wgJz9sVm;
	Tue,  9 Apr 2024 00:31:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712615512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8QwFVAJtzCuy79gcKbncRJk0r4nQm9swsihwEnV6jo=;
	b=fnjQget8KdtmoJI7edO7Rli+CbBnha1MMZA3/8sOyEPn+XT26rwAe9IShAgazZJeG0zXaq
	Os/ZhfI0KkRfQeFwWqOj4i3JX1QpZjZoVEDWeKaopwe1JlMcHDIPXBYuItqCvL4tJGqF2S
	zUAxeaHQ7nwN07XykRy8U/enzvuILYSjtG9zyUCIcs1sAwe/3JnP9cXVkeAy6wymrCVbPW
	gmmBNE3yGhfj0iZARJ2OzmHwLHsIM6cEaAah8Akv0bs6wXUHwW9yI54Xl92PE/65CxBd2E
	dXszDTOxhEGCHiVQV8IhumBUNPkh4Hx0tdl7hMvMWfa0YQVi/dOzsxwybWrC3w==
Message-ID: <bda6c52e-6487-45ef-badf-a061cb670fe9@hauke-m.de>
Date: Tue, 9 Apr 2024 00:31:52 +0200
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 00/10] backports: Remove support for kernel older than
 4.14
To: Johannes Berg <johannes@sipsolutions.net>, backports@vger.kernel.org
References: <20240401220314.2434455-1-hauke@hauke-m.de>
 <14f53b97c5b03fe86e217158dc42407cdbcd04ff.camel@sipsolutions.net>
 <a321cd180adf72a3e20ec316f3385862b132336c.camel@sipsolutions.net>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <a321cd180adf72a3e20ec316f3385862b132336c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4VD3jh5wgJz9sVm

On 4/8/24 4:15 PM, Johannes Berg wrote:
> On Mon, 2024-04-08 at 15:49 +0200, Johannes Berg wrote:
>> On Tue, 2024-04-02 at 00:03 +0200, Hauke Mehrtens wrote:
>>> Remove support for older kernel versions to make maintenance of backports easier in
>>> the future.
>>>
>>
>> No objections, I think (**), but why not also remove 4.15-4.18 since the
>> oldest stable kernel is 4.19.x now? Seems there'd be little value in
>> those then.
> 
> Oh wait, I misread, you're keeping 4.14 which was previously still
> released as a stable kernel, so I guess never mind.
> 
> johannes

Hi Johannes,

I kept it in for now, but will only build test it. If I run into 
problems I will remove 4.14 to 4.18 too.

Hauke
