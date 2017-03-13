
open import Data.Nat using (ℕ; zero; suc)

module Data.Prop.Theorems.Mixies (n : ℕ) where

open import Data.Prop.Syntax n
open import Function using (_$_)


e245b : ∀ {Γ Δ} {φ ψ}
      → Γ ⊢ φ → Δ , φ ⊢ ψ
      → Γ ⨆ Δ ⊢ ψ

------------------------------------------------------------------------
-- Proofs.
------------------------------------------------------------------------

e245b {Γ}{Δ} seq₁ seq₂ =
  ⇒-elim
    (weaken-Δ₂ Γ $ ⇒-intro seq₂)
    (weaken-Δ₁ Δ seq₁)
