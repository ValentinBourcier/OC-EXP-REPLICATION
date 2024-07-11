
# Informal feedback

This file reports all feedback that the experiment participant reported to us informally by direct message after doing the experiment. The participants have been anonymized.

## Feedback

* It was really interesting, I see myself using this while debugging!
* I learned about OCD and can use it in my daily work, so this was useful for me, too. Thank you for this! [later] Yes, it helps. Already used it.

* tu ne sais pas si tu as déjà rencontré le bug quand tu trouves l'objet
* tu ne sais pas quel objet est la source parfois (exemple, on avait un bug graphique avec plein de petits composants visuels imbriqués et on ne savait pas le responsable)

* My biggest pain was that I didn't find a good reason to setup object centric breakpoint for case, where object was incorrectly setup during initialization of the object.  E.g. When I did exercise from OCD experiment, the error came from early initialization of object (when object was created from some other class iterating over stream).  So halt on call, or halt on write was never triggered, since change of inst var did happen during initialization and breakpoint was never invoked again.  
