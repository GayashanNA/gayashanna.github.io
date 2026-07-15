---
layout: page
title: MCQ Autograder
description: OMR-based autograding for paper MCQ exams, saving around LKR 1M a year.
img: assets/img/projects/mcq/card.jpg
importance: 2
category: open source
github: https://github.com/CSE-UoM/MCQAutoGrader
---

MCQAutoGrader implements an Optical Mark Recognition based autograding tool for paper based MCQ questions. The project is mainly designed to be used for CS1033 Programming Fundamentals course offered by the Dept. of Computer Science and Engineering at University of Moratuwa, Sri Lanka.

It was adopted into the department's grading workflow, where it is estimated to save around LKR 1M a year in manual marking effort — the courses it supports run to classes of 1000+ students.

MCQAutoGrader is designed to take a list of scanned answer scripts (bubble sheets) as inputs along with the marking scheme and the template of the bubble sheet. Visit <a href="https://github.com/CSE-UoM/MCQAutoGrader">the project page</a> for further details.
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
