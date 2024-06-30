Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EBC13DDC7
	for <backports@vger.kernel.org>; Sun, 30 Jun 2024 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719778813; cv=none; b=N93KKstswqRBMmv8hndJqm+wVnffedgEsHrZANCkJJVb+odQIbDBjoDzLI6AuG8Sp3j12zkmeixZnu55+H58HFOqNRLOj+1cfHeW5pWIsw9F4SCfoxLukglGJzdgAtfLA7Vwp9rmxFghFCioPSTHKn+rhw6BeFY/F9U/SrUQNdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719778813; c=relaxed/simple;
	bh=EmNONXzJzkpem7XrYmsiukeMxXJPaFfgI+FyypVvdLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PLtSVnCu+H1jpBJBIELleRxQUgjyhiATg+NwNbUM48d8F56eJGnY6DximkZKFAQCbujTz6aDgCFJtRcHsBp05ath3u71TiYtcnlNY53pKQVpN4AaAT62OMUq+nAqMTUcUdQRVjBUBnFWKbkaYyJbpmZVkh36wY6tYMalRofT038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=plTkDGsU; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="plTkDGsU"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WC0sK3gHJz9sT3;
	Sun, 30 Jun 2024 22:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719778805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqDAUXs8KDCfjGdXs7ycD02INSntF1Cwqn5X4FGpsXk=;
	b=plTkDGsUt/nodzHVyLp+dWod6/d8RUwypVFVx8xMaWLname8R7CP9tbeKoJsDGEe6qAKHM
	ghxIrX06iDg3eqyXFt2lq8l7bSXOWFqVRVsrTpP2zbn35u28EvEQVOdCwCCF55n/iS8c2y
	tMzMqNKuRZudxQFZI80RV6aHoI3lKBTfkteIKIz1dewvVYqKuuCixbFBictztdPdvjxhft
	C+FkV53Tve8VtHIdd0csFIEc0E9PxicwZuqhr6sn37QL1TR2FzVkjHcbu9ThG+9+Q4KZ4z
	SKeVXl22KxsQSqZG+QAJpktboN1T+ONizZ/XJg92aP+n1TOQLrmaOJQAQBrTOw==
Message-ID: <dc358b88-c4f1-4806-932c-b7f6d0ff0bf5@hauke-m.de>
Date: Sun, 30 Jun 2024 22:20:04 +0200
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 53/75] patch: Adapt struct pcpu_sw_netstats change to
 u64_stats_t
To: Johannes Berg <johannes@sipsolutions.net>, backports@vger.kernel.org
References: <20240627234808.1253337-1-hauke@hauke-m.de>
 <20240627234808.1253337-54-hauke@hauke-m.de>
 <0ec11d2056890b47f93b74bc224351d5b9f25c40.camel@sipsolutions.net>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <0ec11d2056890b47f93b74bc224351d5b9f25c40.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/28/24 12:47, Johannes Berg wrote:
> On Fri, 2024-06-28 at 01:47 +0200, Hauke Mehrtens wrote:
>> ++#if LINUX_VERSION_IS_GEQ(6,0,0)
>> + 	u64_stats_inc(&stats64->rx_packets);
>> + 	u64_stats_add(&stats64->rx_bytes, skb->len);
>> ++#else
>> ++	stats64->rx_packets++;
>> ++	stats64->rx_bytes += skb->len;
>> ++#endif
> 
> I suspect we _could_ do this with an auto-detect macro?
> 
> #if ... /* < 5.5 */
> #define u64_stats_inc(v) (*v)++
> #define u64_stats_add(v, a) (*v)+=(a)
> #else
> #define u64_stats_inc(v) \
>   do {
> 	if (__builtin_types_compatible(typeof(v), *u64_stats_t)
> 		u64_stats_inc(v);
> 	else
> 		(*v)++;
>   } while(0)
> 
> 
> or so?
> 
> But then it's only one driver here ...
> 
> johannes

I think that should work because u64_stats_inc() and u64_stats_add() are 
not used in other places for now. This patch is needed because of this 
upstream change:
https://git.kernel.org/linus/9962acefbcb92736c268aafe5f52200948f60f3e
It changes the type from u64 to u64_stats_t. The functions are already 
in the kernel for much longer. Even kernel 5.10 uses them on some net 
counters. If we replace all u64_stats_inc() and u64_stats_add() usage 
with the ++ and similar operations this could also affect other places 
where we do not want to do this.

I would prefer to stay with this patch. The code in this area is also 
not changing often.

Hauke
