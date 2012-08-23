MIME-Version: 1.0
Sender: mcgrof@gmail.com
Date: Thu, 23 Aug 2012 19:13:32 +0500
Message-ID: <CAB=NE6X9pq_gnfFgCTYnwwhdaw2VAzxJTN0gMT_R5pWwhk_Teg@mail.gmail.com>
Subject: compat-drivers-2012-08-23 update
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: Konstantin Ryabitsev <mricon@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

Stephen kicked linux-next.git to next-20120823, for this update no
changes were required on either compat or compat-drivers, as such I've
pegged and signed a new tag for both. A cronjob will eventually spit
out results daily as shown below.

Although the first *stable* release will be based on v3.7-rc1, we
should be able to be making daily snapshots based on linux-next.git
now off of kernel.org under the new shiny compat-drivers name. That
will soon be accommodated.

mcgrof@garbanzo ~/devel/compat-drivers (git::master)$ time ckmake
Trying kernel 3.5.0-030500-generic [OK]
Trying kernel 3.4.4-030404-generic [OK]
Trying kernel 3.3.7-030307-generic [OK]
Trying kernel 3.2.2-030202-generic [OK]
Trying kernel 3.1.10-030110-generic [OK]
Trying kernel 3.0.18-030018-generic [OK]
Trying kernel 2.6.39-02063904-generic [OK]
Trying kernel 2.6.38-02063808-generic [OK]
Trying kernel 2.6.37-02063706-generic [OK]
Trying kernel 2.6.36-02063604-generic [OK]
Trying kernel 2.6.35-02063512-generic [OK]
Trying kernel 2.6.34-02063410-generic [OK]
Trying kernel 2.6.33-02063305-generic [OK]
Trying kernel 2.6.32-02063255-generic [OK]
Trying kernel 2.6.31-02063113-generic [OK]
Trying kernel 2.6.30-02063010-generic [OK]
Trying kernel 2.6.29-02062906-generic [OK]
Trying kernel 2.6.28-02062810-generic [OK]
Trying kernel 2.6.27-020627-generic [OK]
Trying kernel 2.6.26-020626-generic [OK]
Trying kernel 2.6.25-020625-generic [OK]
Trying kernel 2.6.24-020624-generic [OK]

real    26m35.163s
user    139m24.143s
sys     13m13.934s

Updated from local tree: /home/mcgrof/linux-next
Origin remote URL:
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
This is a linux-next.git compat-drivers release

compat-drivers code metrics

   1202383 - Total upstream lines of code being pulled
      3041 - backport code changes
      2546 - backport code additions
       495 - backport code deletions
     13767 - backport from compat module
     16808 - total backport code
    1.3979 - % of code consists of backport work
       230 - backport code changes
       180 - backport code additions
        50 - backport code deletions
     13767 - backport from compat module
     13997 - total backport code
    1.1641 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20120823
compat.git: compat-2012-08-23
compat-drivers release: compat-drivers-2012-08-23
Code metrics archive: http://bit.ly/H6BTF7

  Luis
