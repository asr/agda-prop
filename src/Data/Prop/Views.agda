------------------------------------------------------------------------------
-- Agda-Prop Library.
-- Useful views.
------------------------------------------------------------------------------

open import Data.Nat using (ℕ)

module Data.Prop.Views (n : ℕ) where

------------------------------------------------------------------------------

open import Data.Prop.Syntax n

------------------------------------------------------------------------------

data nView : Prop  → Set where
  conj   : (φ₁ φ₂ : Prop) → nView (φ₁ ∧ φ₂)
  disj   : (φ₁ φ₂ : Prop) → nView (φ₁ ∨ φ₂)
  impl   : (φ₁ φ₂ : Prop) → nView (φ₁ ⇒ φ₂)
  biimpl : (φ₁ φ₂ : Prop) → nView (φ₁ ⇔ φ₂)
  nconj  : (φ₁ φ₂ : Prop) → nView (¬ (φ₁ ∧ φ₂))
  ndisj  : (φ₁ φ₂ : Prop) → nView (¬ (φ₁ ∨ φ₂))
  nneg   : (φ₁ : Prop)    → nView (¬ ¬ φ₁)
  ntop   : nView (¬ ⊤)
  nbot   : nView (¬ ⊥)
  nimpl  : (φ₁ φ₂ : Prop) → nView (¬ (φ₁ ⇒ φ₂))
  nbiim  : (φ₁ φ₂ : Prop) → nView (¬ (φ₁ ⇔ φ₂))
  other  : (φ₁ : Prop)    → nView φ₁

n-view : (φ : Prop) → nView φ
n-view (φ₁ ∧ φ₂)     = conj _ _
n-view (φ₁ ∨ φ₂)     = disj _ _
n-view (φ₁ ⇒ φ₂)     = impl _ _
n-view (φ₁ ⇔ φ₂)     = biimpl _ _
n-view (¬ ⊤)         = ntop
n-view (¬ ⊥)         = nbot
n-view (¬ (φ₁ ∧ φ₂)) = nconj _ _
n-view (¬ (φ₁ ∨ φ₂)) = ndisj _ _
n-view (¬ (φ₁ ⇒ φ₂)) = nimpl _ _
n-view (¬ (φ₁ ⇔ φ₂)) = nbiim _ _
n-view (¬ (¬ φ₁))    = nneg _
n-view φ₁            = other _

data ConjView : Prop → Set where
  conj  : (φ₁ φ₂ : Prop) → ConjView (φ₁ ∧ φ₂)
  other : (φ : Prop)     → ConjView φ

conj-view : (φ : Prop) → ConjView φ
conj-view (φ₁ ∧ φ₂) = conj _ _
conj-view φ         = other _

data DisjView : Prop → Set where
  disj  : (φ₁ φ₂ : Prop) → DisjView (φ₁ ∨ φ₂)
  other : (φ : Prop)     → DisjView φ

disj-view : (φ : Prop) → DisjView φ
disj-view (φ₁ ∨ φ₂) = disj _ _
disj-view φ         = other _


data dView : Prop → Set where
  conj  : (φ₁ φ₂ : Prop) → dView (φ₁ ∧ φ₂)
  disj  : (φ₁ φ₂ : Prop) → dView (φ₁ ∨ φ₂)
  other : (φ : Prop)     → dView φ

d-view : (φ : Prop) → dView φ
d-view (φ₁ ∧ φ₂) = conj _ _
d-view (φ₁ ∨ φ₂) = disj _ _
d-view φ         = other _

data dViewAux : Prop → Set where
  case₁ : (φ₁ φ₂ φ₃ : Prop) → dViewAux ((φ₁ ∨ φ₂) ∧ φ₃)
  case₂ : (φ₁ φ₂ φ₃ : Prop) → dViewAux (φ₁ ∧ (φ₂ ∨ φ₃))
  other : (φ : Prop)        → dViewAux φ

d-view-aux : (φ : Prop) → dViewAux φ
d-view-aux ((φ₁ ∨ φ₂) ∧ φ₃) = case₁ _ _ _
d-view-aux (φ₁ ∧ (φ₂ ∨ φ₃)) = case₂ _ _ _
d-view-aux φ                = other _

data cViewAux : Prop → Set where
  case₁ : (φ₁ φ₂ φ₃ : Prop) → cViewAux ((φ₁ ∧ φ₂) ∨ φ₃)
  case₂ : (φ₁ φ₂ φ₃ : Prop) → cViewAux (φ₁ ∨ (φ₂ ∧ φ₃))
  other : (φ : Prop)        → cViewAux φ

c-view-aux : (φ : Prop) → cViewAux φ
c-view-aux ((φ ∧ ψ) ∨ φ₃) = case₁ _ _ _
c-view-aux (φ ∨ (ψ ∧ φ₃)) = case₂ _ _ _
c-view-aux φ              = other _


data ImplView : Prop → Set where
  impl  : (φ₁ φ₂ : Prop) → ImplView (φ₁ ⇒ φ₂)
  other : (φ : Prop)     → ImplView φ

impl-view : (φ : Prop) → ImplView φ
impl-view (φ₁ ⇒ φ₂) = impl _ _
impl-view φ         = other _


data NegView : Prop → Set where
  neg : (φ : Prop) → NegView (¬ φ)
  pos : (φ : Prop) → NegView φ

neg-view : (φ : Prop) → NegView φ
neg-view (¬ φ) = neg _
neg-view φ     = pos _

