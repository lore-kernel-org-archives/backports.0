Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trego-co-il.20230601.gappssmtp.com header.i=@trego-co-il.20230601.gappssmtp.com header.b="g2ucQ/wr"
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6A9FF
	for <backports@vger.kernel.org>; Mon,  4 Dec 2023 05:37:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-332c0c32d19so4091851f8f.3
        for <backports@vger.kernel.org>; Mon, 04 Dec 2023 05:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trego-co-il.20230601.gappssmtp.com; s=20230601; t=1701697031; x=1702301831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTGoRMOx013YuhcQLaP5uDnn7Vie1eOPP13uvA4Aabc=;
        b=g2ucQ/wr8qmN09RRBcjQpS52MI63lCBayF+/k98ilaXjvWet0NmLtK3OPLnVqUhoBh
         dj1RpnyMJ3bgtSt/a2ntWo2TiJX2RRDIETszJNMAsc7e8TjxtfFOEzuS6PtvrVqOjNjK
         00ubSQXcrI+58eaO4hVERB8m6r1y/xTiqNVEPPpr22o91djRMzWs8u6myfGL4e3S1vqS
         4xt6i3XsFQL81tVCtqLR9KpOBbVynNOjZULECDVQzoyc5uLj5ghxDmDsK/6SMAS1KpjA
         VNc9spWte3QC8uV04eeDF+puGgpPQ/WUFg28qm9LUDl1pkFWRpLdN8eZzpfXc3EqkILP
         aLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701697031; x=1702301831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTGoRMOx013YuhcQLaP5uDnn7Vie1eOPP13uvA4Aabc=;
        b=uONjz0aHxOG4+w+g62vgl9n7x48p/gDVJPZ2mkZbi0LlEIhEppHvRvn6PJpc0CEBgm
         3t2P+AH2rIyDoA1e2KhfxXYOvQX0ZNmAnQtJyT3nXutovkztCKt0oIA3LtdjpqzgE5z5
         fOt39Yl1+QAkbep91fi6sNZZoLWa4Beqa72P4FWuUpULoJ7EUmUmbMpa7eDhwFPd7LwO
         HZZEdJM/PbafUxEyXyhDMrDIy0EX+2dZUgqKkPJ8uXCkTHSwXo7HsbcSDrbW/SADNZY1
         OWz1tRG3qxDwxlZ7uI+Lx+fPqJm8FQl2IWH8wF32plCjX5JuzYwrBXSW3QDyQQOlO44v
         OGmg==
X-Gm-Message-State: AOJu0YxA6GCvqAcRc/XW5PagVBOjdLpHunbIjP8Sc3pIjn2yIIJVDjZc
	WLVTiWBsCux8cM854cDkdu1PYPu5cujhpMuZsut23Q==
X-Google-Smtp-Source: AGHT+IHc9I8CIi71YeMGioNyDCvCD4c4V0NC1Dv+lVT1/wEEWFobaWWoXgopojxSCJ5o9gLSr1dn9w==
X-Received: by 2002:adf:f145:0:b0:333:2fd2:2f13 with SMTP id y5-20020adff145000000b003332fd22f13mr3159564wro.140.1701697031518;
        Mon, 04 Dec 2023 05:37:11 -0800 (PST)
Received: from cristie14.c-scale.ro ([86.120.182.23])
        by smtp.gmail.com with ESMTPSA id cp6-20020a056000400600b003334520e49bsm3917398wrb.53.2023.12.04.05.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:37:10 -0800 (PST)
From: Cristian Cimpianu <cristi@trego.co.il>
To: backports@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
 Brian Witte <brianwitte@mailfence.com>
Cc: eyal@trego.co.il
Subject: Re: backports for wifi-7 and kernel 6.5
Date: Mon, 04 Dec 2023 15:36:25 +0200
Message-ID: <2093282.J6tISVfHaF@cristie14.c-scale.ro>
In-Reply-To: <447949051.552711.1700847486717@ichabod.co-bxl>
References:
 <31498106.Y1g1iz2YYI@cristie14.c-scale.ro>
 <e6e3719a-9ca1-4a24-b898-38eec2c1da62@lwfinger.net>
 <447949051.552711.1700847486717@ichabod.co-bxl>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Thanks a lot guys.

That tree seems to have contributions from all the right people and it seems to generate a working 6.5 tree.

br,
Cristian.

On vineri, 24 noiembrie 2023 19:38:07 EET Brian Witte wrote:
> 
> > ----------------------------------------
> > From: Larry Finger <Larry.Finger@lwfinger.net>
> > Date: Nov 24, 2023, 7:34:16 AM
> > 
> > Christian,
> > 
> > I do not know the details, but Brian Witte (Cc'd here) recently informed me that 
> > Felix Flietkau has a backports tree for kernel 6.5.
> > 
> > Larry
> > 
> > 
> 
> Cristian,
> 
> I was asking questions on #backports IRC channel since I also am trying to get a
> more up-to-date backports release. I had started patching from 5.15 and was
> making some progress, but it was going slower than I'd like and then Hauke
> shared this tree with me:
> 
> https://github.com/nbd168/backports
> 
> It appears to be on 6.5, I have only pulled the code at this point and haven't
> fully tested it since we had a holiday here in US and I have been traveling and
> with family.
> 
> Felix is maintaining that tree for OpenWrt from what I have been told.
> You can see various 6.x backports tarballs here if you search "backports":
> 
> https://mirror2.openwrt.org/sources/
> 
> I am going to be digging into this for Realtek backports repos that Larry and I
> work on. It seems like there is some renewed interest in backports these
> days, haha.
> 
> Let me know if I can help in any way as I am working on similar problems.
> 
> I will report back if any issues come while working with Felix's tree. I am very
> grateful it was shared with me to say the least...
> 
> Brian Witte
> 




