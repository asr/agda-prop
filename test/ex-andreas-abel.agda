------------------------------------------------------------------------------
-- Exercises for Type Theory CM0859 (Prof. Andreas Abel).
-- http://www1.eafit.edu.co/asr/courses/type-theory-CM0859/exercises.pdf
------------------------------------------------------------------------------

open import Data.PropFormula 2 public

ex1 : ∀ {φ}
    → ∅ ⊢ φ ⊃ φ

ex1 {φ} = ⊃-intro (assume {Γ = ∅} φ)

ex2 : ∀ {φ ψ}
    → ∅ ⊢ (φ ∧ (φ ⊃ ψ)) ⊃ ψ

ex2 {φ}{ψ} =
  ⊃-intro $
    ⊃-elim
      (∧-proj₂ $ assume {Γ = ∅} (φ ∧ (φ ⊃ ψ)))
      (∧-proj₁ $ assume {Γ = ∅} (φ ∧ (φ ⊃ ψ)))

ex3 : ∀ {φ ψ γ}
    → ∅ ⊢ (φ ∧ (ψ ∨ γ)) ⊃ ((φ ∧ ψ) ∨ (φ ∧ γ))

ex3 {φ}{ψ}{γ} =
  ⊃-intro $
    ⊃-elim
      (⊃-intro $
        ∨-elim {Γ = ∅ , (φ ∧ (ψ ∨ γ))}
          (∨-intro₁ (φ ∧ γ) $
            ∧-intro
              (∧-proj₁ $ weaken ψ $ assume {Γ = ∅} (φ ∧ (ψ ∨ γ)))
              (assume {Γ = ∅ , (φ ∧ (ψ ∨ γ)) } ψ))
          (∨-intro₂ (φ ∧ ψ) $
            ∧-intro
              (∧-proj₁ $ weaken γ $ assume {Γ = ∅} (φ ∧ (ψ ∨ γ)))
              (assume {Γ = ∅ , (φ ∧ (ψ ∨ γ))} γ )))
    (∧-proj₂ $ assume {Γ = ∅} (φ ∧ (ψ ∨ γ)))

ex4 : ∀ {φ ψ}
    → ∅ ⊢ (¬ φ ∨ ψ) ⊃ (φ ⊃ ψ)

ex4 {φ}{ψ} =
  ⊃-intro $
    ∨-elim {Γ = ∅}
      (⊃-intro $
        ⊥-elim {Γ = ∅ , ¬ φ , φ} ψ
          (¬-elim
            (weaken φ $
              assume {Γ = ∅} (¬ φ))
            (assume {Γ = ∅ , ¬ φ} φ)))
      (⊃-intro $
        weaken φ $
          assume {Γ = ∅} ψ)

ex5 : ∀ {φ ψ}
    → ∅ ⊢ ¬ (φ ∨ ψ) ⊃ (¬ φ ∧ ¬ ψ)

ex5 {φ}{ψ} =
  ⊃-intro $
    ∧-intro
      (¬-intro $
        ¬-elim
          (weaken φ $
            assume {Γ = ∅} (¬ (φ ∨ ψ)))
          (∨-intro₁ ψ $
            assume {Γ = ∅ , ¬ (φ ∨ ψ)} φ))
      (¬-intro $
        ¬-elim
          (weaken ψ $
            assume {Γ = ∅} (¬ (φ ∨ ψ)))
          (∨-intro₂ φ $
            assume {Γ = ∅ , ¬ (φ ∨ ψ)} ψ))

¬¬EM : ∀ {Γ} {φ}
     → Γ ⊢ ¬ ¬ (φ ∨ ¬ φ)

¬¬EM {Γ}{φ} =
  ¬-intro $
    ¬-elim
      (assume {Γ = Γ} (¬ (φ ∨ ¬ φ)))
      PEM


RAA⊃EM
  : ∀ {Γ} {φ}
  → Γ ⊢ φ ∨ ¬ φ

RAA⊃EM {Γ}{φ} =
  RAA
    (¬-elim
      (¬¬EM {Γ = Γ , ¬ (φ ∨ ¬ φ)} )
      (assume {Γ = Γ} (¬ (φ ∨ ¬ φ))))


EM⊃Pierce
  : ∀ {Γ} {φ ψ}
  → Γ ⊢ ((φ ⊃ ψ) ⊃ φ) ⊃ φ

EM⊃Pierce {Γ}{φ}{ψ} =
  ⊃-elim
    (⊃-intro
      (∨-elim {Γ = Γ}
        (⊃-intro
          (weaken ((φ ⊃ ψ) ⊃ φ)
            (assume {Γ = Γ} φ)))
        (⊃-intro
          (⊃-elim
            (assume {Γ = Γ , ¬ φ} ((φ ⊃ ψ) ⊃ φ))
              (⊃-intro
                (⊥-elim
                  ψ
                  (¬-elim
                  (weaken φ
                    (weaken ((φ ⊃ ψ) ⊃ φ)
                      (assume {Γ = Γ} (¬ φ))))
                      (assume {Γ = Γ , ¬ φ , (φ ⊃ ψ) ⊃ φ} φ))))
            ))))
      PEM


postulate
  RAA'
    : ∀ {Γ} {φ}
    → Γ ⊢ ( ¬ φ ⊃ φ) ⊃ φ


RAA'⊃RAA : ∀ {Γ}{φ}
         → Γ ⊢ ¬ (¬ φ) ⊃ φ

RAA'⊃RAA {Γ}{φ} =
  ⊃-intro
    (⊃-elim
      RAA'
      (⊃-intro
        (⊥-elim
          φ
          (¬-elim
            (weaken (¬ φ) (assume  {Γ = Γ } ( ¬ (¬ φ))))
            (assume  {Γ = Γ , ¬ (¬ φ) } (¬ φ)))
         )))

postulate
  Pierce : ∀ {Γ} {φ} {ψ}
         → Γ ⊢ ((φ ⊃ ψ) ⊃ φ) ⊃ φ

Pierce⊃RAA' : ∀ {Γ}{φ}
            → Γ ⊢ ( ¬ φ ⊃ φ ) ⊃ φ

Pierce⊃RAA' {Γ}{φ} =
  ⊃-intro $
    ⊃-elim
      (Pierce {Γ = Γ , ¬ φ ⊃ φ} {φ = φ} {ψ = ⊥})
      (⊃-intro $
        ⊃-elim
          (weaken (φ ⊃ ⊥) $
            assume {Γ = Γ} ((¬ φ) ⊃ φ))
          (¬-equiv₂ $
            assume {Γ = Γ , (¬ φ) ⊃ φ}
              (φ ⊃ ⊥)
          )
      )


