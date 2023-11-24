Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hezxp3rl"
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313B8172B
	for <backports@vger.kernel.org>; Fri, 24 Nov 2023 05:34:25 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b845ba9ba9so1098438b6e.3
        for <backports@vger.kernel.org>; Fri, 24 Nov 2023 05:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700832864; x=1701437664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LkPXacSjkDleNps/AJ4C1DbLtEw48NHCB4CMgmGbt80=;
        b=hezxp3rlQQ9PV7h0ssHpFG3t4hHeBSvPOAycp8YcZruUNWojj/bzfU2d9xU0PoM84d
         XAQZn88mL8bR1KL/BoXQsrjarVZCKBkj7EH24KubbDpekCgKWptighPUXpTGxfS1dBcT
         7sA/uBdH7NluFjE41PpQIrx4MTfArgCAKPnCRt7cFp14D/IeFMGyto53H+gjamKlYJ9Z
         AdqLYZbbIAaq8YD2VKWzY9J4BiQYxXDJKMuMw/Mo4nPHiZbFu27fgcqjH3MklgIC/mLm
         i5+kiLE3gzNzGUlMaW1CppMkKXWq37xkICc7VsuekiCM7zWLxp7nWEnnBbvhRuueLpgq
         Wq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700832864; x=1701437664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkPXacSjkDleNps/AJ4C1DbLtEw48NHCB4CMgmGbt80=;
        b=Z0kdW98GCQDOKlYVCpLaKddxd9E7n4cUVfboKhhZ5TbgpbIoT2LYFXNMt9i+4z+GY7
         0PZhj293x3of4Hmi/CBSryF7J7MneGRmGUH3ITslhum1ynMUt6Hol6Fa2IjHAaA8jFoE
         uumM7Q+n5tMgq/yAP8QKkMX0MjndW1FaS1AZ0mi0o6bFeRL6CPOurA2F2wC/NZSJZUH+
         zcFyujx3D3sSzlol2gRlqjuY7GL9nGawwo7szBvd8VizInB/JLlucv1KKgazUeo41ccj
         qne7UlulpWRZRkVlzQr9yMSMQKl/wJDEh5jcqvBFKOMc2u1lu1+gTCs22PeyUNfQyPNd
         cNSA==
X-Gm-Message-State: AOJu0YxpZV/5SLqtGJciYCU5E12Wrz64bBHbQEE494uxWyAjzMKjsI1V
	C42Ld87c/NlC6Jmw0bWLx/usx+jNL3ufoQ==
X-Google-Smtp-Source: AGHT+IH4W2hdtQMxb5yg9+dzvR8qqOmsCC7S4uPZ1Wlon10YOkNHMlA/GZ6FnPAOdmUbYTRgz5PHBQ==
X-Received: by 2002:a05:6808:1b25:b0:3b5:75ad:5b73 with SMTP id bx37-20020a0568081b2500b003b575ad5b73mr3576446oib.13.1700832864432;
        Fri, 24 Nov 2023 05:34:24 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r40-20020a056808212800b003ae425fc9bdsm485532oiw.23.2023.11.24.05.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 05:34:24 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <e6e3719a-9ca1-4a24-b898-38eec2c1da62@lwfinger.net>
Date: Fri, 24 Nov 2023 07:34:16 -0600
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: backports for wifi-7 and kernel 6.5
Content-Language: en-US
To: Cristian Cimpianu <cristi@trego.co.il>, backports@vger.kernel.org
Cc: eyal@trego.co.il, brian witte <brianwitte@mailfence.com>
References: <31498106.Y1g1iz2YYI@cristie14.c-scale.ro>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <31498106.Y1g1iz2YYI@cristie14.c-scale.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/23 08:24, Cristian Cimpianu wrote:
> Hi guys,
> 
> I've been working on a project using the backports project to build some custom wifi modules for different kernel versions.
> Now the customer wants to do a wifi-7 chip keeping the infrastructure the same as much as possible. But wifi-7 has been added into kernel 6.5, while the backports project is still at 5.15. And the customer wants that in like 6 months.
> So, in the hope I will understand better what would be the easiest solution, I figured I could ask here.
> Is there a plan to add support in the backports project for kernel 6.5 or for the wifi-7 changes to the mac80211 and cfg80211 modules?

Christian,

I do not know the details, but Brian Witte (Cc'd here) recently informed me that 
Felix Flietkau has a backports tree for kernel 6.5.

Larry


