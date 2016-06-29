---
layout: old-wiki-page
permalink: /micro-os-plus/i/SE_SRS_guide/
title: SE SRS guide
author: Liviu Ionescu

date: 2011-09-17 21:52:23 +0000

---

Credits
=======

The following recommendations are based on chapter 4.7 of [Real-Time Systems Design and Analysis (Third Edition), by Phillip A. Laplante, published by Wiley & Sons in 2004](http://www.amazon.com/Real-Time-Systems-Analysis-Phillip-Laplante/dp/0471228559).

IEEE Standard 830-1998
======================

There are many ways to organize the SRS, but [IEEE Standard 830-1998](http://standards.ieee.org/findstds/standard/830-1998.html) is the IEEE’s Recommended Practice for Software Requirements Specifications (SRS), and provides a template of what an SRS should look like.

The SRS is described as a “binding contract among designers, programmers, customers, and testers,” and it encompasses different design views or paradigms for system design. The recommended design views include some combination of decomposition, dependency, interface, and detail descriptions.

Basic issues
============

The basic issues that the SRS writer(s) shall address are the following:

-   Functionality - What is the software supposed to do?
-   External interfaces - How does the software interact with people, the system's hardware, other hardware, and other software?
-   Performance - What is the speed, availability, response time, recovery time of various software functions, etc.?
-   Attributes - What are the portability, correctness, maintainability, security, etc. considerations?
-   Design constraints imposed on an implementation - Are there any required standards in effect, implementation language, policies for database integrity, resource limits, operating environment(s) etc.?

Limitations
===========

The SRS writer(s) should avoid placing either design or project requirements in the SRS.

The SRS writer(s) should be careful not to go beyond the bounds of that role. This means the SRS

-   Should correctly define all of the software requirements. A software requirement may exist because of the nature of the task to be solved or because of a special characteristic of the project.
-   Should not describe any design or implementation details. These should be described in the design stage of the project.
-   Should not impose additional constraints on the software. These are properly specified in other documents such as a software quality assurance plan.

Therefore, a properly written SRS limits the range of valid designs, but does not specify any particular design.

Good requirements
=================

Whatever approach is used in organizing the SRS, the IEEE 830 standard describes the characteristics of good requirements. That is, good requirements must be.

1.  *Correct* - They must correctly describe the system behavior.
2.  *Unambiguous* - The requirements must be clear, not subject to different interpretations.
3.  *Complete* - There must be no missing requirements. Ordinarily, the note TBD [to be defined (later)] is unacceptable in a requirements document. IEEE 830 sets out some exceptions to this rule. Consistent One requirement must not contradict another. Consistency can be checked using formal methods, as illustrated previously.
4.  *Ranked* - for importance and/or stability Not every requirement is as critical as another. By ranking the requirements, designers will find guidance in making trade-off decisions.
5.  *Verifiable* - A requirement that cannot be verified is a requirement that cannot be shown to have been met.
6.  *Modifiable* - The requirements need to be written in such a way so as to be easy to change. In many ways, this approach is similar to the information hiding principle.
7.  *Traceable* - The benefits of traceability cannot be overstated. The requirements provide the starting point for the traceability chain. Numbering the requirements in hierarchical fashion can aid in this regard.

Best practices
==============

To meet these criteria and to write clear requirements documentation, there are several best practices that the requirements engineer can follow. These are as follows:

-   Invent and use a standard format and use it for all requirements.
-   Use language in a consistent way.
-   Use “shall” for mandatory requirements.
-   Use “should” for desirable requirements.
-   Use text highlighting to identify key parts of the requirement.
-   Avoid the use of technical language unless it is warranted.

To illustrate, consider the following bad requirements:

1.  “The systems shall be completely reliable.”
2.  “The system shall be modular.”
3.  “The system shall be maintainable.”
4.  “The system will be fast.”
5.  “Errors shall be less than 99%.”

These requirements are bad for a number of reasons. None are verifiable, for example, how is “reliability” supposed to be measured? Even requirement 5 is vague, that is, what does “less than 99% mean”?

Content
=======

Table of contents
-----------------

The recommended table of contents for an SRS is:

    1. Introduction
      1.1 Purpose
      1.2 Scope
      1.3 Definitions and Acronyms
      1.4 References
      1.5 Overview
    2. Overall Description
      2.1 Product Perspective
      2.2 Product Functions
      2.3 User Characteristics
      2.4 Constraints
      2.5 Assumptions and Dependencies
    3. Specific Requirements
    Appendices
    Index

Purpose
-------

This subsection should

-   Delineate the purpose of the SRS;
-   Specify the intended audience for the SRS.

Scope
-----

This subsection should

-   Identify the software product(s) to be produced by name (e.g., Host DBMS, Report Generator, etc.);
-   Explain what the software product(s) will, and, if necessary, will not do;
-   Describe the application of the software being specified, including relevant benefits, objectives, and goals;
-   Be consistent with similar statements in higher-level specifications (e.g., the system requirements specification), if they exist.

Definitions, acronyms, and abbreviations
----------------------------------------

This subsection should provide the definitions of all terms, acronyms, and abbreviations required to properly interpret the SRS. This information may be provided by reference to one or more appendixes in the SRS or by reference to other documents.

References
----------

This subsection should

-   Provide a complete list of all documents referenced elsewhere in the SRS;
-   Identify each document by title, report number (if applicable), date, and publishing organization;
-   Specify the sources from which the references can be obtained.

Overview
--------

This subsection should

-   Describe what the rest of the SRS contains;
-   Explain how the SRS is organized.

Product perspective
-------------------

This subsection of the SRS should put the product into perspective with other related products. If the product is independent and totally self-contained, it should be so stated here. If the SRS defines a product that is a component of a larger system, as frequently occurs, then this subsection should relate the requirements of that larger system to functionality of the software and should identify interfaces between that system and the software.

A block diagram showing the major components of the larger system, interconnections, and external interfaces can be helpful.

This subsection should also describe how the software operates inside various constraints. For example, these constraints could include

-   System interfaces;
-   User interfaces;
-   Hardware interfaces;
-   Software interfaces;
-   Communications interfaces;
-   Memory;
-   Operations;
-   Site adaptation requirements

(for details, please see the original document)

Product functions
-----------------

This subsection of the SRS should provide a summary of the major functions that the software will perform.

User characteristics
--------------------

This subsection of the SRS should describe those general characteristics of the intended users of the product including educational level, experience, and technical expertise. It should not be used to state specific requirements, but rather should provide the reasons why certain specific requirements are later specified in Section 3 of the SRS.

Constraints
-----------

This subsection of the SRS should provide a general description of any other items that will limit the developer's options. These include

-   Regulatory policies;
-   Hardware limitations (e.g., signal timing requirements);
-   Interfaces to other applications;
-   Parallel operation;
-   Audit functions;
-   Control functions;
-   Higher-order language requirements;
-   Signal handshake protocols (e.g., XON-XOFF, ACK-NACK);
-   Reliability requirements;
-   Criticality of the application;
-   Safety and security considerations.

Assumptions and dependencies
----------------------------

This subsection of the SRS should list each of the factors that affect the requirements stated in the SRS. These factors are not design constraints on the software but are, rather, any changes to them that can affect the requirements in the SRS. For example, an assumption may be that a specific operating system will be available on the hardware designated for the software product. If, in fact, the operating system is not available, the SRS would then have to change accordingly.

Specific requirements
---------------------

This section of the SRS should contain all of the software requirements to a level of detail suficient to enable designers to design a system to satisfy those requirements, and testers to test that the system satisfies those requirements.

These requirements should include at a minimum a description of every input (stimulus) into the system, every output (response) from the system, and all functions performed by the system in response to an input or in support of an output.

-   Specific requirements should be stated in conformance with all the characteristics described in 4.3.
-   Specific requirements should be cross-referenced to earlier documents that relate.
-   All requirements should be uniquely identifiable.
-   Careful attention should be given to organizing the requirements to maximize readability

Various items that comprise requirements

-   External interfaces
-   Functions
-   Performance requirements
-   Logical database requirements
-   Design constraints
-   Standards compliance
-   Software system attributes
-   Reliability
-   Availability
-   Security
-   Maintainability
-   Portability
-   Organizing the specific requirements
    -   System mode
    -   User class
    -   Objects
    -   Feature
    -   Stimulus
    -   Response
    -   Functional hierarchy
-   Additional comments

Appendixes
----------

The appendixes are not always considered part of the actual SRS and are not always necessary. They may include

-   Sample input/output formats, descriptions of cost analysis studies, or results of user surveys;
-   Supporting or background information that can help the readers of the SRS;
-   A description of the problems to be solved by the software;
-   Special packaging instructions for the code and the media to meet security, export, initial loading, or other requirements.

Categories of Words
===================

Imperatives
-----------

Imperatives found in requirements specifications and their purpose

-   *Shall* - Dictates provision of fundamental capability
-   *Must* - Establishes performance requirements or constraints
-   *Must not* - Establishes performance requirements or constraints
-   *Is required to* - Used in specifications statements written in passive voice
-   *Are applicable* - Used to include, by reference, standards or other documentation as an addition to the requirements being specified
-   *Responsible for* - Used as an imperative for systems whose architectures are already defined
-   *Will* - Generally used to cite things that the operational or development environment are to provide to the capability being specified
-   *Should* - Not recommended for use

Continuances
------------

Continuances follow an imperative and introduce the specification of requirements at a lower level. Continuances include:

-   “Below”
-   “As follows”
-   “Following”
-   “Listed”
-   “In particular”
-   “Support”

Options
-------

Options give the developer latitude in satisfying the specifications, and include:

-   “Can”
-   “May”
-   “Optionally”

Weak phrases
------------

Weak phrases, which should be avoided in SRS, include:

-   “Adequate”
-   “As a minimum”
-   “As applicable”
-   “Be able to”
-   “Be capable”
-   “But not limited to”
-   “Capability of”
-   “Capability to”
-   “Effective”
-   “If practical”
-   “Normal”
-   “Provide for”
-   “Timely”
-   “TBD”

Requirements validation
=======================

Verification of the software product means ensuring that the software is conforming to the SRS. Verification is akin to asking the question “Am I building the software right?” in that it requires satisfaction of requirements.

Requirements validation, on the other hand, is tantamount to asking the question “Am I building the right software?” Too often, software engineers deliver a system that conforms to the SRS, only to discover that it is not what the customer really wanted.

Performing requirements validation involves checking the following:

1.  Validity, that is, does the system provide the functions that best support the customer’s needs?
2.  Consistency, that is, are there any requirements conflicts?
3.  Completeness, in other words, are all functions required by the customer included?
4.  Realism, or, can the requirements be implemented given available budget and technology?
5.  Verifiability, that is, can the requirements be checked?

There are a number of ways of checking the SRS for conformance to the IEEE 830 best practices and for validity. These approaches include:

1.  Requirements reviews.
2.  Systematic manual analysis of the requirements.
3.  Prototyping.
4.  Using an executable model of the system to check requirements.
5.  Test-case generation.
6.  Developing tests for requirements to check testability.
7.  Automated consistency analysis.
8.  Checking the consistency of a structured requirements description.
