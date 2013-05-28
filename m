Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:62030 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788Ab3E1Tez (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 15:34:55 -0400
Received: by mail-we0-f182.google.com with SMTP id q57so5467876wes.13
        for <backports@vger.kernel.org>; Tue, 28 May 2013 12:34:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369325176.12002.31.camel@jlt4.sipsolutions.net>
References: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
 <1369278956-17550-9-git-send-email-mcgrof@do-not-panic.com> <1369325176.12002.31.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 28 May 2013 12:34:33 -0700
Message-ID: <CAB=NE6WG7mYYgWb=Xsx8qc14BwAEdfR6s7bspCegTWg8moi6WQ@mail.gmail.com> (sfid-20130528_213509_092246_0A5C9ED3)
Subject: Re: [PATCH v3 8/8] gentree.py: add kernel upload support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, May 23, 2013 at 9:06 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>
>> +def get_rel_spec_stable(rel):
>> +    """
>> +    Returns release specs for a linux-stable backports based release.
>> +    """
>> +    if ("rc" in rel):
>
> I really think you should drop those parentheses on ifs, it looks
> weirdly C-ish and this is python :-)

Ah I missed that on my new iteration, will address this next.

>> +        m = re.match(r"(?P<VERSION>\d+)\.+" \
>> +                     "(?P<PATCHLEVEL>\d+)[.]*" \
>> +                     "(?P<SUBLEVEL>\d*)" \
>> +                     "[-rc]+(?P<RC_VERSION>\d+)\-+" \
>
> "[-rc]+" seems weird, don't you just want "(-rc)?"

Indeed, thanks.

> And then in fact I think you don't need the "if rc in" above?

Will revise, thanks.

>> +    if (not m):
> ditto

OK!

>> +    m = re.match(r"(?P<DATE_VERSION>\d+)[-]*" \
>
> "[-]*" is odd, why not just write "-*" if that's what you want? Maybe
> you actually want "-+", otherwise there's no boundary between
> DATE_VERSION and RELMOD_UPDATE.

-* it is, given that RELMOD_UPDATE can be empty as per the defined
rules on naming convention on releases for backports described in
upload_release()

>> +    if (not rel_specs):
>> +        rel_specs = get_rel_spec_next(rel)
>> +        if (not rel_specs):
>> +            sys.stdout.write("rel: %s\n" % rel)
>
> print ?

I'll nuke.

>> +        paths.append(year)
>> +        paths.append(month)
>> +        paths.append(day)
>> +        rel_tag = "backports-" + rel.replace(rel_specs['RELMOD_TYPE'], "")
>> +    else:
>> +        ignore = "-"
>> +        if (not rel_specs['RELMOD_UPDATE']):
>> +            return None
>> +        if (rel_specs['RELMOD_UPDATE'] == '0'):
>> +            return None
>> +        ignore += rel_specs['RELMOD_UPDATE']
>> +        if (rel_specs['RELMOD_TYPE'] != ''):
>> +            ignore += rel_specs['RELMOD_TYPE']
>> +        base_rel = rel.replace(ignore, "")
>> +        paths.append(base_rel)
>> +        rel_tag = "v" + rel.replace(rel_specs['RELMOD_TYPE'], "")
>> +
>> +    rel_prep = dict(stable = is_stable,
>> +                    expected_tag = rel_tag,
>> +                    paths_to_create = paths)
>> +    return rel_prep
>
> I truly don't understand this function.

OK so I figured it'd be good to lay out a defined pattern for
releases. Based on previous releases and practices this is defined on
the documentation of upload_release(). Given that in this iteration
--git-revision is not used *and* that older releases had -snpc
possible tags and that these additional postfix arguments were never
used as part of the signed digital tag on the tree for releases this
routine:

1) verifies that rules on upload_release() are followed
2) throws back the expected git tag on the backports tree
3) throws back the list of directories that need to be created, given
kup does not support mkdir -p, and given that the directory path
varies if its a stable release also determine if its a stable release
or not

> Also, what's with the dict? Why
> not just return a tuple:
>         return (is_stable, rel_tag, paths)

Just what I have been used to, is tuple preferred in the Python world
in these cases where you have to return multiple data?

>> +    parent = os.path.dirname(args.outdir)
>> +    release = os.path.basename(args.outdir)
>> +    tar_name = parent + '/' + release + ".tar"
>> +    bzip2_name = tar_name + ".bz2"
>> +
>> +    create_tar_and_bz2(tar_name, args.outdir)
>
> I'd recommend creating it in a temporary directory.

Under what parent directory?

> In fact, I'd
> recommend making args.outdir optional in this case (which needs some
> refactoring) and making _it_ a subdir in a temp directory too?

Sure, but what parent directory to use then?

>> @@ -289,16 +464,22 @@ def _main():
>>                     git_revision=args.git_revision, clean=args.clean,
>>                     refresh=args.refresh, base_name=args.base_name,
>>                     gitdebug=args.gitdebug, verbose=args.verbose,
>> -                   extra_driver=args.extra_driver, logwrite=logwrite)
>> +                   extra_driver=args.extra_driver,
>> +                   kup=args.kup,
>> +                   kup_test=args.kup_test,
>> +                   logwrite=logwrite)
>>
>>  def process(kerneldir, outdir, copy_list_file, git_revision=None,
>>              clean=False, refresh=False, base_name="Linux", gitdebug=False,
>> -            verbose=False, extra_driver=[], logwrite=lambda x:None,
>> +            verbose=False, extra_driver=[], kup=False,
>> +            kup_test=False,
>> +            logwrite=lambda x:None,
>>              git_tracked_version=False):
>
> That may just be me, but maybe you should be consistent and put more
> things on one line (or reformat the other lines?)

I'm more of a fan of the later given that then patches address
argument per argument. Will send a patch for that, or address this
after.

>> @@ -309,10 +490,48 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
>>              self.gitdebug = gitdebug
>>              self.verbose = verbose
>>              self.extra_driver = extra_driver
>> +            self.kup = kup
>> +            self.kup_test = kup_test
>> +    def git_paranoia(tree=None, logwrite=lambda x:None):
>
> This is a really strange place to define a function?

It didn't seem to make sense to share this globally on the file. Is
this not good practice?

>>      # start processing ...
>> +    if (args.kup or args.kup_test):
>> +        git_paranoia(source_dir, logwrite)
>
> This part might not be handled by my git-revision suggestion, but then
> maybe it'd be better to actually point the scripting to a

It seems you left off writing what you wanted to on this part of the
thread. I would assume you were alluding to the idea that perhaps its
good to point the script to a backports git tag to use to check out as
well ?

>> +        git_paranoia(kerneldir, logwrite)
>> +
>> +        rel_describe = git.describe(rev=None, tree=source_dir, extra_args=['--dirty'])
>> +        release = os.path.basename(args.outdir)
>
> Taking the file path for a release description seems like a strange
> thing to do? Maybe you should pass it on the command line?

Indeed, this is just trying to reuse the args.outdir but technically
we should be able to infer the target release name from the backports
git tag in place with the caveat that we still have to address the
additional flags for releases (-s -n -p -c -u). If that's done though
then maybe its better to not require an args.outdir and instead have a
args.tmp_rel_path or else assume a /tmp/ random dir would be used and
use the git tag from backports to infer the release (-s -n -p -c -u
still pending as additional tags to peg later).

Thanks for the feedback, this really helps.

  Luis
