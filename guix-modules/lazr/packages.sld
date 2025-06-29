
(define-library (lazr packages)
  (export oh-my-zsh
          font-cmu-nerdfont)

  (import (scheme base)
	  (guix packages)
	  (guix licenses)
	  (guix git-download)

	  (guix build-system copy)
	  (guix build-system gnu)
	  (guix build-system python)
	  (guix build-system trivial)
	  (guix build-system font)

	  (gnu packages shells)
	  (guix gexp))
  
  (begin 

    (define font-cmu-nerdfont
      (let ((revision "2")
            (commit "dd09d3e5fe40ca79d51ccb8e12ef7af8a36965e4"))
        (package
         (name "font-cmu-nerdfont")
         (license silofl1.1)
         (version (git-version "1.0.0" revision commit))
         (synopsis "Computer Modern Unicode with Nerd Font glyphs")
         (description "This is a patched version of Donald E. Knuth's fonts based on the TTF CMU set. The patch includes all Nerd Font glyphs.")
         (home-page "https://github.com/kindjie/cmu_nerdfont")
         (source (origin 
                  (method git-fetch)
                  (uri (git-reference 
                        (url "https://github.com/kindjie/cmu_nerdfont")
                        (commit commit)))
                  (file-name (git-file-name name version))
                  (sha256
                   (base32 "0z4rg9s3qhmy5r3nqzr38g693bv2p68bi3g0xcsifwdlqs2rhfqs"))))
         (build-system font-build-system))))

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
			(commit "2fbdfa93f942611c56bb02657a39f577bd7f0ef0")))
		  (file-name (git-file-name name version))
                  (sha256
                   (base32 "0wwwh5h15gwk68k30wh4bnyy7wbz9v80khgf86gql0gmipzm5038"))))
	(inputs (list zsh))
	(build-system copy-build-system)
	(arguments
	 (list
	  #:install-plan
	  #~'(("oh-my-zsh.sh" "/share/zsh/oh-my-zsh/")
	      ("lib/" "/share/zsh/oh-my-zsh/lib")
	      ("plugins/" "/share/zsh/oh-my-zsh/plugins/")
	      ("templates/" "/share/zsh/oh-my-zsh/templates/")
	      ("themes/" "/share/zsh/oh-my-zsh/themes/")
	      ("tools/" "/share/zsh/oh-my-zsh/tools/"))))
	))
    ))
