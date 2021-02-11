                     Dynamic ISPF w/SHRPROF Support

Dynamic ISPF:
    - What is Dynamic ISPF?
      Dynamic ISPF is a method of utilizing the ISPF Environment that
      allocates as many ISPF/TSO resource as possible only when they are
      needed. In most cases, the standard ISPF & TSO Library types, and
      their elements, are dynamically allocated just prior to launching
      a particular application or function; and then dealoccatted on
      exiting it.

    - Why Dynamic ISPF?
      1. Performance improvements
         - Under ISPF & TSO LIBDEFed & ALTLIBed DSNs are search 1st.
         - Most pieces of ISPF/TSO applications are bundle into the
           supplied product libraries. So, there is usually no reason
           to search elsewhere for a piece.
         - Shorter lists mean fewer cycles to find a piece.
         - Shorter concatinations mean fewer cycles to load a piece.
         - The later 2 usually:
           -- Mean a more responsive user experiance
           -- Outway the cost of the dynamic allocations, which IBM
              continues to make more efficient.
      2. Manageability simplification & standardization
         - If you use a product like PLP (or TRX) you can vastly
           simplify enabling an ISPF/TSO product for your user
           community.  No need for every product support person to be a
           CLIST or REXX Expert
         - Centralized & Standard Management, so every product support
           individual knows where to start when doing support.
      3. Availability improvements
         - Product maintenance only impacts that product & individuals
           using (trying to use) that product. If does not impact others
           users of the same TSO LOGON PROC and other work that does
           not depend on the product undergoing maintenance.
         - One product is much less likely to impact another product.
           So, fewer issues & simpler debugging. This is because each
           product has its own, dynamic, concatination (vs the shared
           concatination of the TSO LOGON PROC); so there is less likely
           issues where one product attempts to use a component & picks
           up another products version of a like named component.
         - A "bad" product will only impact those attempting to use it,
           when they attempt to use it. Under a static ISPF/TSO
           environment, a "bad" product may prevent all users of TSO
           LOGON PROCs with that product available to experience the
           issue; this may include preventing them from being able to
           LOGON to TSO/ISPF!
      4. Security simplification & improvements
         - Fewer TSO LOGON PROCs to manage the Security of
         - No longer have to give out unnecessary access to a product
           because it is in Share Static TSO LOGON PROC.
         - Easier auditing of who uses security sensitive product, i.e.
           Security is at the Product level vs TSO LOGON PROC level.
      5. Maintenance simplification & standardization
         - Simplified & Standardized Access Availability
         - Less cross product "contamination"; so, less cross product
           issues to debug.
         - Simplified debugging when an issue occures, as you usually
           do not need to worry about other products. Also, when trying
           to chase down how/where something is being done; you usually
           only need to worry about the products libraries and not all
           the libraries (& products) in the TSO LOGON PROC.
         - With the correct Dynamic Product, a product support person
           can easily disable the product during a maintenance cycle
           without impaction other ISPF/TSO Users.
           For Example, using PLP you can replace the startup Command
           with a standard "Maintenance REXX/APP" that informs the user
           an application is undergoing maintenance & when it will be
           available again. This prevents users from envoking the
           product when it is not in a fully functional state and
           ensures those doing the maintenance normal ISPF use will not
           impact them as they implement maintenance.

ISPF SHRPROF Support:
    1. Part of IBM's Solution to allowing ISPF Users to logon to
       multiple zOS Images within the same Sysplex at the same time
    2. Part of IBM's Solution to allowing ISPF Users to use a single
       ISPF Profile on multiple zOS images within a Sysplex w/o having
       to worry about having different configuration states when on
       different images.

Attaining zOS High Availability (via IBM's standard vision):
    1. A zOS Sysplex is multiple zOS Images that appear to the end
       user as a single system.
    2. Under the correct circumstances, if the Sysplex is available
       (possibly only a single zOS Image is running), the End User
       sees the system as up.
    3. To accomplish this, the zOS System Programmers & those designing
       major sub-systems (e.g. IBM's TSO/ISPF Environment) need to
       design to allow transparent movement from one zOS Image to
       another. When done properly, an IPL is NOT an outage for the
       System in question.
    4. System & major Sub-System maintenance is designed to NOT require
       an IPL to implement.
    5. In many cases, the Sysplex will traverse some distance (at least
       different data centers, probably different power grids). In
       these cases automation is setup to help move systems from zOS
       Image to zOS Image; either when manually envoked or when an
       image loss is detected.


Why Dynamic ISPF & SHRPROF Support:
    To allow the TSO/ISPF Environment to play in a High Availavility
    environment you really need to implement both Dynamic ISPF/TSO &
    ISPF SHRPROF support. If not be prepared for high overhead, lower
    availability,& lower service levels.

    Why do I say this? In our enviroment we had:
      1. 2 zOS Images within our Sysplex (3 w/Techie testing Image).
      2. 5 General groups of ISPF/TSO users (5 different use requirement)
      3. A typical, aged, Static ISPF/TSO environment
      4. Products & Support requirements to required some users to logon
         to multiple images at the same time.
      5. A new requirement to add a few more zOS Images to implement a High
         Availability Environment.

    This had resulted in:
      - 12+ different LOGON PROC, when you include Techie Testing &
        user Acceptance versions (different PROCs, for Different Groups,
        on different Images).
      - 12+ different ISPF Startup REXXes (on each of the LOGON PROCs).
        Some of these were Image Aware and started things based on the
        image they were on.
      - 15+ ISPF Primary Panel.
      - 3+ ways to get into each ISPF/TSO Product/App; usually different
        for each Image, sometimes also because how they were envoked (e.g.
        from the ISPF Primary Panel and ISPF Command line, as was QuickRef)
      - 3+ sets of "Standard" ISPF Libraries (mostly tied to zOS Image)

    This also resulted in:
      - Very de-centralize administration of ISPF/TSO Products/Apps
      - Many, very different methods to envoke ISPF/TSO Products/Apps
      - Complaints from users that options had changed on them (usually
        because they were using a different ISPF PROFILE), only because
        they changed thier LOGON PROC or the Image they Logged onto.
      - Very difficult environment to roll out ISPF/TSO Product changes.
        To allow us to do this, we almost always changed all the
        Product/App DSNs everytime we did maintenance ... and then
        changed all 12+ different LOGON PROCs, and/or 12+ Startup REXXes,
        and/or 15+ Primary Panels, and/or 3+ methods to start the
        Product/App. Plus, it usually required an IPL to coordinate this!
      - Much time trying to figure out why a Product/App was not working
        for an Individual, or small group.
        -- Did I miss one of the changes?
        -- Did I test all the invocations, for all the IDs, on all the
           Images (and what are all these combinations)!?!?
        -- Was there a compatibility issues with one of the Product Mixes?
        -- Where is the support individual whom implemented this (I am
           too lost that I require their assistance to untangle this).
        -- Does Walgreens deliver, as I have run out of Asprin again!?!?
      - ...
      - Nightmares trying to figure out how to implement this in a High
        Availability environment (our new requirement).  :¬o

With Dynamic ISPF w/SHRPROF Support we now have:
      - 1 User LOGON PROC (actually 2 w/Techie PROC)
      - 1 Dynamic ISPF Primary Panel
      - 1 Centralized & Standard method of envoking ISFP/TSO Products/Apps
      - All Users use a single personal ISPF PROFILE, reguardless of Image.
      - Fewer cross product issues
      - Fewer casses of missing updates to our environment when doing
        ISPF/TSO Product/App maintenance.
      - Reduced IPL & TSO Outage requirements for product implementations.
      - 3 sets of "Standard" ISPF/TSO Libraries (Shop, Techie, & Personal)
      - An ISPF/TSO Environment that scales within a High Availability
        environment w/o changes to "our" infrastructure (some products may
        need some changes, but ISPF/TSO does not).
      - A bottle of Asprin in my drawer that is not empty!  :¬)
