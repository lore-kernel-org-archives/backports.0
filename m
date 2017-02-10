Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38889 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbdBJWsJ (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 10 Feb 2017 17:48:09 -0500
Received: by mail-wm0-f48.google.com with SMTP id r141so60608098wmg.1
        for <backports@vger.kernel.org>; Fri, 10 Feb 2017 14:48:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486505323.18071.2.camel@sipsolutions.net>
References: <20170207220716.7538-1-johannes@sipsolutions.net> <1486505323.18071.2.camel@sipsolutions.net>
From: Steve deRosier <derosier@gmail.com>
Date: Fri, 10 Feb 2017 14:48:07 -0800
Message-ID: <CALLGbRL52oFgX09x7JRcfVkRmAFQ-x61uwpJjMLcLP21BEeoNw@mail.gmail.com> (sfid-20170210_234811_755610_2D288534)
Subject: Re: [RFC] backports: always use new version compare macros
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Feb 7, 2017 at 2:08 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> It's some churn, but I think worthwhile - any objections?
>

No objections from me, seems a bit easier to read and a bit less code.

- Steve
--
To unsubscribe from this list: send the line "unsubscribe backports" in
