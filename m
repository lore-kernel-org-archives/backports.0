Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34077 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbbGQEYO (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 17 Jul 2015 00:24:14 -0400
MIME-Version: 1.0
In-Reply-To: <CA+P7+xrOPS6NeQhte-ATdm2Nqo0PpmUAxS+XYzWDvZGtwPtWMw@mail.gmail.com>
References: <CAB=NE6XRnKAY6t+dxT7vO_4wqngXvULh-CqezEAs2r99FkNCTg@mail.gmail.com>
 <0add7d95076f5b112af90d8566c29203@www.dscho.org> <CAB=NE6VGX332=CvhQM4sc27AM8ae5S1kdRnm5sMfoqkU=b=ebg@mail.gmail.com>
 <CAB=NE6UFMv0qu8fJ1P2-pJCF0tSGKoW+uKhfwt0jV5fj2wZGSQ@mail.gmail.com> <CA+P7+xrOPS6NeQhte-ATdm2Nqo0PpmUAxS+XYzWDvZGtwPtWMw@mail.gmail.com>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Thu, 16 Jul 2015 21:23:54 -0700
Message-ID: <CA+P7+xq=J76N16XETKkUhRJKyShPtg4-K0aMjE5+_LzBJQ-t3A@mail.gmail.com> (sfid-20150717_062416_777748_2E6CCFB3)
Subject: Re: GNU diff and git diff - difference on myers algorithm?
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Jul 16, 2015 at 9:22 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Jul 16, 2015 at 12:07 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>> On Fri, Jun 12, 2015 at 11:52 AM, Luis R. Rodriguez
>> <mcgrof@do-not-panic.com> wrote:
>>> OK wells I'm curious about more research / effort when trying to
>>> evaluate a diff with two seprate but adjoining preprocessor directives
>>> and if anyone has implemented an optimizaiton option to let the diff
>>> generator join them.
>>>
>>> For example, to let it infer that:
>>>
>>> --- a/test.c
>>> +++ b/test.c
>>> @@ -10,8 +10,6 @@ int main(int argc, char *argv[])
>>>
>>>  #ifdef FOO
>>>         a = 4;
>>> -#endif /* FOO */
>>> -#ifdef FOO
>>>         a = 5;
>>>  #endif /* FOO */
>>>
>>> is possible.
>>
>> Anyone familiar if any tool exists today that would optimize this? Is
>> anyone working on it? Would git be a good place for such a thing? I'd
>> consider it as an option to optimize a diff. This for example is
>> extremely useful for us working with Coccinelle where we have a tool
>> writing code for us, while such an optimization might be useful to
>> Coccinelle it would seem like a rather generic feature, its just not
>> clear to me where to give such a tool a proper home.
>>
>>  Luis
>
> I do not understand exactly what would be optimized in this case?
>
> In any regards, that's not a diff transformation, that is a code
> transformation, and I would suggest starting with Coccinelle and
> seeing if you can get that to do what you want.
> http://coccinelle.lip6.fr/
>
> Regards,
> Jake

I misread your comment. Coccinelle is a tool that could probably be
coerced into doing this, but this is not a diff optimization unless I
am completely understanding it. This is a code transformation concept,
and doesn't have much to do with finding differences or code changes.
My above comment is correct, but I don't think this belongs in diff
parsing, but rather as part of something like Coccinelle

Regards,
Jake
--
To unsubscribe from this list: send the line "unsubscribe backports" in
