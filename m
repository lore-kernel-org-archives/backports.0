Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:38603 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757811Ab3DBBWX convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 1 Apr 2013 21:22:23 -0400
Received: by mail-la0-f53.google.com with SMTP id fr10so2638399lab.12
        for <backports@vger.kernel.org>; Mon, 01 Apr 2013 18:22:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <63F46C2DA34879449F56E238025B3C0B54CEDC9F@fe20107s.ecn.etasgroup.com>
References: <63F46C2DA34879449F56E238025B3C0B54CEDB13@fe20107s.ecn.etasgroup.com>
 <CAB=NE6VShWL_CLURZMNPacTyz44Hmj6iNLoN25PehK3V2ML5jA@mail.gmail.com> <63F46C2DA34879449F56E238025B3C0B54CEDC9F@fe20107s.ecn.etasgroup.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 1 Apr 2013 18:22:02 -0700
Message-ID: <CAB=NE6WqLbAZB2bi6jLhMmaABa5X7++LKYZsM2ktbhcRHB4GeA@mail.gmail.com> (sfid-20130402_032225_880707_09F09B83)
Subject: Re: compat-drivers for older kernels
To: "Jonathan David (AA-DG/PAO-ENG1)" <David.Jonathan@etas.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 1, 2013 at 3:16 PM, Jonathan David (AA-DG/PAO-ENG1)
<David.Jonathan@etas.com> wrote:
> Thanks for the clarification.  I'll certainly return patches if/when I am successful.
>
> One more thing I'm betting you can answer relates to the LINUX_VERSION macros: How do you find in what kernel version a feature changed (e.g. tty->driver->write became tty->ops->write)?  I can't imagine it's by inspection,  yet a cross-reference site like lxr.linux.no, which should be able to spit that out, does not.

I've documented this here:

https://backports.wiki.kernel.org/index.php/Documentation/compat#Tracking_down_when_a_feature_went_upstream

  Luis
