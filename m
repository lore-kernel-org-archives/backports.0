Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2D47F45
	for <backports@vger.kernel.org>; Sun, 30 Jun 2024 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719782953; cv=none; b=omf/ARxd/0QObhIbFQBza69VthP4k7M9LrdQqH1hft6HNr8v8QG4ufpn0lw7EBQSQOWb9aGXhD5LTTcc3Iw9KsUbGOPOx9A2Br27UnI8mZ2lpu2BLhrxUmiHCtK/d2WFv7slrGfXpI2FJI6/D+GYOtbJ4If/tD6SaXuNHAJWmGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719782953; c=relaxed/simple;
	bh=qJHM+bzrghWhRga/gITRZbqTBNQueoK4xP57xes8Oa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYp+H2DHmNqLNk4WdiQXI4xXc/B87Nj1U4ZQ1gVoRvKtu3TB/5rCIPjfsE73lQVr3dN3M2Z6l38EYwN2KhACxSKTAGle0k1emBceEWy/oYnNr1xmkttH+spvpUkzMq/XWB6zETNYvO3XvFqRyHGwvmpQc+eoqf0o/5yZ9cyZDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=FczkOSeQ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="FczkOSeQ"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WC2Ns1R3sz9sHh;
	Sun, 30 Jun 2024 23:29:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719782941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T94SaD/z+eDzwHQdYDNIWn5MlJ0ApWdWmneys8goKag=;
	b=FczkOSeQwzuq5+APi/K2PFYyUsgGtllubItnuTpXkFQPV7TFpcrIQTR0cr9BimrPXr0ncx
	9vDb/ZksIeP5kruVEr2M507aLiL1SFRCDpKjanUM5VtYAVDXvIa2D0edRwmukJZLPHC4dC
	En3x34+Wc8VO3FmiKHRilzi5Xmypm2nVE4LfQqpYZUiilJemHlLhHyM1QShaw86grXMmS+
	p8b6NZK8PgS9VeQKeDEpMu4dlOZa/590kkLJSzkEz/ULfWP3VYboJmCD7S/h2gxbbOAckH
	S8hE01AyRzvnk8grfm/9s8E7a3XXr0dg0v5vXFMoDMN5vDHXH2wav1+QdvEHbg==
Message-ID: <7883f0ee-3e69-47d7-802b-4a7f03ced2a4@hauke-m.de>
Date: Sun, 30 Jun 2024 23:28:59 +0200
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 10/75] backports: bpgit: handle copied files properly in
 status()
To: Johannes Berg <johannes@sipsolutions.net>, backports@vger.kernel.org
Cc: Luciano Coelho <luciano.coelho@intel.com>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
 <20240627234808.1253337-11-hauke@hauke-m.de>
 <dfba94b755d73f6342a70f8a1a25e56f2ebb0316.camel@sipsolutions.net>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <dfba94b755d73f6342a70f8a1a25e56f2ebb0316.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/24 12:34, Johannes Berg wrote:
> On Fri, 2024-06-28 at 01:46 +0200, Hauke Mehrtens wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> 'C' as the setatus also has two files, so need to continue
> 
> correcting myself, I guess - 'status'
>>
>> Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/135974
> 
> Also here.
> 
> johannes

Fixed it and removed all the Intel specific tags form all commits.

Hauke
