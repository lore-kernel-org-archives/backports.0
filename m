Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trego-co-il.20230601.gappssmtp.com header.i=@trego-co-il.20230601.gappssmtp.com header.b="ZRSwyKDD"
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5282A1A8
	for <backports@vger.kernel.org>; Thu, 23 Nov 2023 06:25:21 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a02ba1f500fso135590166b.0
        for <backports@vger.kernel.org>; Thu, 23 Nov 2023 06:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trego-co-il.20230601.gappssmtp.com; s=20230601; t=1700749519; x=1701354319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SBnfnvpnuj4sr33Np2zVK8dmfqunLDb9uQnDgFp1Q/w=;
        b=ZRSwyKDDUikRh28LkXhutXnfv0KJyGPyEAAvpjzFECivFOu/WmwGQHhrNJX4ZXhQlD
         uw4cED2/yFgTuephXxbwKD2zi7AP2tV9BKchNHXh/7rxKRuVIgdqXJWGf9IIRXTb10CS
         1tPJF6oPyIx34emK3KfI7c1D3wwYGT7HhJYbp2/dHGTASGLY1ZZ3WMHFVB6nT2bgk+Nn
         s8oXId/f78IVclxNeyoOOTwK7jIzHMm8od8E6DepEoFBMcXQ/Ie1e4106usfoodEh8yi
         foror3id/7k8gsvPrdR3aCJTYjWjTE0/hVeaBGZljP+6zyXi0eAehtcsFnz6BUWnVV6N
         RSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700749519; x=1701354319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBnfnvpnuj4sr33Np2zVK8dmfqunLDb9uQnDgFp1Q/w=;
        b=jDFTxXX6SGGJ7X212MU1iNEfdyb4wqNXjdZdg2JaiW4zFMVO/vU0nndM3bWTUiKOQx
         NzPxuTI9vx4HGbW75m94ievKNDS+t05kgCNmFhE7vvi+ywEkeiswCEqv+TXgo5o2cohk
         AC/mQ6v/pB4avUf6pyG/G262drwEwfitjqtPIjiZUM2OBe6HCrX047fFMF7xR67kWWzq
         e4w76fo6OfrkqeDC5yoXmRzxS1lRspjyclHoYZYXGWbLg53VJiFVmPLby4oo/fapHNUz
         nZ+5pT/9Jexr6YP3V5Uf1pocMcfr7GtakmruSl4KXVRHi8JSa7lw27wevS4TAnh1h3EI
         Xa8g==
X-Gm-Message-State: AOJu0YxN+zGQeFjAUkGM71M4grHZRHKVRpmchwTJ3ATLlHb6ysA9T2Pl
	d75Tb9kZqiGNImYSxsI+DjWKXkmdx0KhGA2SpUA=
X-Google-Smtp-Source: AGHT+IGycAyINgEGQkY9AV1i52XbTh/nDKEC3MIJDWhhNGFOUi6mgPhGlhHmBVUix2WMAXC5Lz+Rkw==
X-Received: by 2002:a17:906:19c:b0:9b2:cf77:a105 with SMTP id 28-20020a170906019c00b009b2cf77a105mr4134803ejb.15.1700749519354;
        Thu, 23 Nov 2023 06:25:19 -0800 (PST)
Received: from cristie14.c-scale.ro ([86.125.16.242])
        by smtp.gmail.com with ESMTPSA id bv8-20020a170906b1c800b009fc927023bcsm842889ejb.34.2023.11.23.06.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:25:18 -0800 (PST)
From: Cristian Cimpianu <cristi@trego.co.il>
To: backports@vger.kernel.org
Cc: eyal@trego.co.il
Subject: backports for wifi-7 and kernel 6.5
Date: Thu, 23 Nov 2023 16:24:35 +0200
Message-ID: <31498106.Y1g1iz2YYI@cristie14.c-scale.ro>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi guys,

I've been working on a project using the backports project to build some custom wifi modules for different kernel versions.
Now the customer wants to do a wifi-7 chip keeping the infrastructure the same as much as possible. But wifi-7 has been added into kernel 6.5, while the backports project is still at 5.15. And the customer wants that in like 6 months.
So, in the hope I will understand better what would be the easiest solution, I figured I could ask here.
Is there a plan to add support in the backports project for kernel 6.5 or for the wifi-7 changes to the mac80211 and cfg80211 modules?

best regards,
Cristian.


