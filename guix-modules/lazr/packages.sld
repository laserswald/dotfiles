
(define-library (lazr packages)
  (export 
   oh-my-zsh
   python-llm)

  (import
   (scheme base)
   (guix packages)
   (guix licenses)
   (guix git-download)

   (guix build-system copy)
   (guix build-system gnu)
   (guix build-system python)
   (guix build-system trivial)

   (gnu packages shells)
   (guix gexp)
   )
  
  (begin 

    (define oh-my-zsh
      (package
       (name "oh-my-zsh")
       (license expat)
       (version "master")
       (synopsis "Configuration framework for the Zsh shell")
       (description
	"Oh My Zsh is a delightful, open source, community-driven framework for managing your Zsh configuration.
It comes bundled with thousands of helpful functions, helpers, plugins, themes, and a few things that make you shout 'Oh My ZSH!' ")
       (home-page "Framework for the Zsh shell")
       (source (origin 
                (method git-fetch)
                (uri (git-reference 
                      (url "https://github.com/ohmyzsh/ohmyzsh")
                      (commit "master")))
		(file-name (git-file-name name version))
                (sha256
                 (base32 "0p149mikcj5q88cqh04x8y0mrmb52y5ch3gcqhdfxadr6vk3b33p"))))
       (inputs (list zsh))
       (build-system copy-build-system)
       (arguments
	(list
	 #:install-plan
	  #~'(("oh-my-zsh.sh" "/share/zsh/oh-my-zsh/")
	      ("lib/" "/share/zsh/oh-my-zsh/")
	      ("plugins/" "/share/zsh/oh-my-zsh/")
	      ("templates/" "/share/zsh/oh-my-zsh/")
	      ("themes/" "/share/zsh/oh-my-zsh/")
	      ("tools/" "/share/zsh/oh-my-zsh/"))))
       ))
   ))
