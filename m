Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F21D52B
	for <backports@vger.kernel.org>; Sun,  7 Jul 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720387229; cv=none; b=ntKfFHmUoVITAJf6jhH1GF3mDLX/Rc6HJmjih66FED1h27wHBMOawjMWAbmRvdqEv2ypD3bHsj5g2R2QQNb8DzMvxtn+L9Lcmi+Ol5kYxl3/ZjoQ0iXBBdb/AzYKjnUETnq7NwGPbK5aBEVPzFbIUcz2E6M+QbZdC8isVuufNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720387229; c=relaxed/simple;
	bh=X8VrA4+kDj80vyQqdvI0Fz8GSnYlAjeTaA3z/0JrTsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DnWqkrXM7u5FRKSjRXt2anartzyv/JtX4S7crj3RyeBrI6w/c+wq7DHU69U6bHF3LmTtxWd0wPSp/eBB6clLGdVnM7W+jLqp4+iKuHwyqBBDP9EvZ3BwDIZccQ9htIZ+D1FPvvdo9krp2VXdIdSKUyjKtoXRXqvfygYKhUdQiNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=PQBySoj+; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="PQBySoj+"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WHKsY0cZRz9sWt;
	Sun,  7 Jul 2024 23:20:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1720387217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGMlNqhYxvCu6W5G15dQjxj8BeQOSM5WX1VbgK1fe+M=;
	b=PQBySoj++83Xo5dNmbjp7ywQSRjj9ZcQPcGxk/7bE51wYvT5XZxgfTZWdiy33JJ5kUJ/KY
	EzIKda28AKW1puWMMWI+EDy3Mv3IGbpltvIfAIoP8WPhWZ/vB+3iec1IDFk+dxZweuVud0
	XLkxGek514yAafktGjGR9PQX0+7m8UzJIElz3moVYN7Y9ibC5K7y1UFKF5RbR1bNQt4NXc
	maFM4+OELTnZHZuy4ThEp0Kk4lRP3IaWAl56ELw62FX0zh7pLRSsdzjvvDSpO3/OgfF1BI
	YdoJqctbtBs6pjFrTfKuZjZc+UJqlDxR86D0xOrOGH+Q+P1t8X1d28h7X4mWOg==
Message-ID: <f518f105-07dd-47b9-92de-ace0a0557b61@hauke-m.de>
Date: Sun, 7 Jul 2024 23:20:16 +0200
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 00/74] backport updates from Intel
To: Johannes Berg <johannes@sipsolutions.net>, backports@vger.kernel.org
References: <20240524170906.54680-76-johannes@sipsolutions.net>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20240524170906.54680-76-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4WHKsY0cZRz9sWt

On 5/24/24 19:07, Johannes Berg wrote:
> So ... I talked to Brian today, and realized that we've been
> sort of maintaining backports to some extent, but not really.
> 
> This is what we have in our tree that's not upstream, and
> rebased onto upstream (commit c96f36d5214).
> 
> With the copy-list restricted to the iwlwifi driver and hwsim
> it even works, but the copy-list as-is doesn't even work, it
> even contains some files that no longer exist.
> 
> But it's a start, and it's a lot of stuff that's not upstream
> yet.
> 
> johannes
> 
> 

Hi Johannes,

I pushed the changes supporting kernel 6.1 to master.
Could you please rebase the patches on top of current master.

Hauke
