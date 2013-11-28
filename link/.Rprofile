options("width"=160)                # wide display with multiple monitors
options("digits.secs"=3)            # show sub-second time stamps

r <- getOption("repos")             # hard code the US repo for CRAN
r["CRAN"] <- "http://cran.us.r-project.org"
options(repos = r)
rm(r)

## put something this is your .Rprofile to customize the defaults
setHook(packageEvent("grDevices", "onLoad"),
        function(...) grDevices::X11.options(width=8, height=8, 
                                             xpos=0, pointsize=10, 
                                             #type="nbcairo"))  # Cairo device
                                             #type="cairo"))    # other Cairo dev
                                             type="xlib"))      # old default

## from the AER book by Zeileis and Kleiber
options(prompt="R> ", digits=4, show.signif.stars=FALSE)
