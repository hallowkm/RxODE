\name{genShinyApp.template}
\alias{genShinyApp.template}
\alias{write.template.server}
\alias{write.template.ui}
\title{
   Generate an example (template) of a dosing regimen shiny app
}
\description{
   Create a complete shiny application for exploring dosing regimens
   given a (hardcoded) PK/PD model.
}
\usage{
genShinyApp.template(appDir = "shinyExample", verbose = TRUE,
ODE.config = list(
   ode = "
   C2 = centr/V2;
   C3 = peri/V3;
   d/dt(depot) =-KA*depot;
   d/dt(centr) = KA*depot - CL*C2 - Q*C2 + Q*C3;
   d/dt(peri)  =                    Q*C2 - Q*C3;
   d/dt(eff)  = Kin - Kout*(1-C2/(EC50+C2))*eff; 
   ",
   
   params = 
      c(KA=.294, CL=18.6, V2=40.2, Q=10.5, V3=297.0,
        Kin=1.0, Kout=1.0, EC50=200.0),
        
   inits = c(depot=0, centr=0, pari=0, eff=1),
   stiff = TRUE,
   atol  = 1e-08,
   rtol  = 1e-06
  )
)
}
\arguments{
  \item{appDir}{
  a string with a directory where to store the shiny app, by default
  is \code{"shinyExample"}.
  The directory \code{appDir} will be created if it does not exist.
}
  \item{verbose}{
  logical specifying whether to write messages as the shiny app
  is generated. Defaults to \code{TRUE}.
}
  \item{ODE.config}{
  a list of ODE configurations with components: (1) ode: a string of
  differential equations; (2) params: a named vector of system parameters
  in ODEs; (3) inits: initial values of the ODEs; (4) stiff: logical 
  specifying whether to use a stiff ODE solver; (5) atol: absolute error
  tolerance when solving ODEs; (6) atol: relative error
  tolerance when solving ODEs.
}
}
\details{
A PK/PD model is defined using \code{\link{RxODE}}, and
a set of parameters and initial values are defined.  Then
the appropriate R scripts for the shiny's user interface \code{ui.R} 
and the server logic \code{server.R} are created in the 
directory \code{appDir}.

The function evaluates the following PK/PD model:
\preformatted{
   C2 = centr/V2;
   C3 = peri/V3;
   d/dt(depot) =-KA*depot;
   d/dt(centr) = KA*depot - CL*C2 - Q*C2 + Q*C3;
   d/dt(peri)  =                    Q*C2 - Q*C3;
   d/dt(eff)  = Kin - Kout*(1-C2/(EC50+C2))*eff; 
}

To launch the shiny app, simply issue the \code{runApp(appDir)}
R command.
}
\value{
   None, these functions are used for their side effects.
}
\note{
   These functions create a simple, but working example of a dosing
   regimen simulation web application. Users may want to modify the code 
   to experiment creating shiny applications for their specific 
   \code{RxODE} models.
}

\seealso{
  \code{\link{RxODE}}, \code{\link{eventTable}}, and the
  package \pkg{shiny} (\url{shiny.rstudio.com}.
}
\examples{
\dontrun{
   # create the shiny app example (template)
   genShinyApp.template(appDir = "myapp")

   # run the shiny app
   runApp("myapp")
}
}
\keyword{simulation}
\keyword{nonlinear}
\concept{PK/PD}
\concept{pharmacometrics}
