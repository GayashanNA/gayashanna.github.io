---
layout: page
title: MCQ Autograder
description: OMR-based autograding for paper MCQ exams, saving around LKR 1M a year.
img: assets/img/projects/mcq/card.jpg
importance: 2
category: Open Source
github: https://github.com/CSE-UoM/MCQAutoGrader
---

MCQAutoGrader is an Optical Mark Recognition tool for grading paper based multiple choice exams. It was written for the CS1033 Programming Fundamentals course at the Department of Computer Science and Engineering, University of Moratuwa, Sri Lanka, where classes run to more than a thousand students and marking them by hand is a serious cost. It was adopted into the department's grading workflow and is estimated to save around LKR 1M a year in manual effort.

It takes a set of scanned answer scripts, a marking scheme, and the bubble sheet template, then reads the marks and grades the scripts. The <a href="https://github.com/CSE-UoM/MCQAutoGrader">project page</a> has the setup instructions.

<div class="row">
    <div class="col-sm mt-3 mt-md-0" >
        {% include figure.html path="assets/img/projects/mcq/template.jpg" title="Template" class="img-fluid rounded z-depth-1" style="width: 50%;height: auto;" %}
    </div>
</div>
<div class="caption">
    Template of a bubble sheet.
</div>

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/projects/mcq/marking_scheme.jpg" title="Marking scheme" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Marking scheme containing the correct answers.
</div>

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/projects/mcq/student_answer.jpg" title="Student's answer" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Sample answer script from a student.
</div>
