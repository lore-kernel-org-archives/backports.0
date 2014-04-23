Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:41069 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206AbaDWS1l (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 23 Apr 2014 14:27:41 -0400
Received: by mail-la0-f48.google.com with SMTP id gf5so1126290lab.35
        for <backports@vger.kernel.org>; Wed, 23 Apr 2014 11:27:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1398251810.4173.6.camel@jlt4.sipsolutions.net>
References: <53579593.40306@kpanic.de> <1398249715.4173.3.camel@jlt4.sipsolutions.net>
 <5357A065.3020400@kpanic.de> <1398251810.4173.6.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Wed, 23 Apr 2014 11:27:19 -0700
Message-ID: <CAB=NE6W2FqvbkwiTeV-aoOOqzmRqwbjpYkF05sosF4+wg7gY1Q@mail.gmail.com> (sfid-20140423_202744_005845_18440B8F)
Subject: Re: cocci: multiple versions of function with different arguments
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Stefan Assmann <sassmann@kpanic.de>,
	Julia Lawall <julia.lawall@lip6.fr>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Apr 23, 2014 at 4:16 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>> If for some reason cocci should have a problem with this the fallback
>> to a define is a good idea.
>
> I don't disagree that we might have to solve this cocci problem, but I
> would much prefer the define over the cocci patch as it leaves the
> output code closer to the input code, which can be important for some
> use cases (e.g. ours - development based on a backport tree.)

Coccinelle has a slight overhead cost in comparison to using our
headers through defines, static inlines, or a new exported symbol on
the backports module (called compat now). The code generation cost is
is O(0) for a backport done through the headers / backports module,
using Coccinelle we have a slight overhead before compile time, during
code generation time. We want to minimize this as much as possible.
Because of this I would also prefer a define for the example use case
unless there's another reason that a define or a new symbol cannot be
used. We should use Coccinelle to try to solve backports for solutions
we didn't have strategies for, that is we should strive to backport
first through the backports module / header files, then as a second
step consider Coccinelle, and only if Coccinelle cannot solve our
backports we leave nasty legacy patches lying around.

  Luis
