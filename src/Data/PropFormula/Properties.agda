------------------------------------------------------------------------------
-- Agda-Prop Library.
-- Properties.
------------------------------------------------------------------------------

open import Data.Nat using ( ℕ )

module Data.PropFormula.Properties ( n : ℕ ) where

------------------------------------------------------------------------------

open import Data.Bool.Base using ( Bool; false; true; not; T )
open import Data.Fin       using ( Fin ; suc; zero )

open import Data.PropFormula.Syntax n
open import Data.PropFormula.Dec n

open import Relation.Binary.PropositionalEquality using ( _≡_ ; refl ; cong )

------------------------------------------------------------------------------

suc-injective : ∀ {o} {m n : Fin o} → Fin.suc m ≡ Fin.suc n → m ≡ n
suc-injective refl = refl

var-injective : ∀ {x x₁} → Var x ≡ Var x₁ → x ≡ x₁
var-injective refl = refl

∧-injective₁ : ∀ {φ φ₁ ψ ψ₁} → (φ ∧ φ₁) ≡ (ψ ∧ ψ₁) → φ ≡ ψ
∧-injective₁ refl = refl

∧-injective₂ : ∀ {φ φ₁ ψ ψ₁} → (φ ∧ φ₁) ≡ (ψ ∧ ψ₁) → φ₁ ≡ ψ₁
∧-injective₂ refl = refl

∨-injective₁ : ∀ {φ φ₁ ψ ψ₁} → (φ ∨ φ₁) ≡ (ψ ∨ ψ₁) → φ ≡ ψ
∨-injective₁ refl = refl

∨-injective₂ : ∀ {φ φ₁ ψ ψ₁} → (φ ∨ φ₁) ≡ (ψ ∨ ψ₁) → φ₁ ≡ ψ₁
∨-injective₂ refl = refl

⊃-injective₁ : ∀ {φ φ₁ ψ ψ₁} → (φ ⊃ φ₁) ≡ (ψ ⊃ ψ₁) → φ ≡ ψ
⊃-injective₁ refl = refl

⊃-injective₂ : ∀ {φ φ₁ ψ ψ₁} → (φ ⊃ φ₁) ≡ (ψ ⊃ ψ₁) → φ₁ ≡ ψ₁
⊃-injective₂ refl = refl

⇔-injective₁ : ∀ {φ φ₁ ψ ψ₁} → (φ ⇔ φ₁) ≡ (ψ ⇔ ψ₁) → φ ≡ ψ
⇔-injective₁ refl = refl

⇔-injective₂ : ∀ {φ φ₁ ψ ψ₁} → (φ ⇔ φ₁) ≡ (ψ ⇔ ψ₁) → φ₁ ≡ ψ₁
⇔-injective₂ refl = refl

¬-injective : ∀ {φ ψ} → ¬ φ ≡ ¬ ψ → φ ≡ ψ
¬-injective refl = refl

-- Def.
_≟_ : {n : ℕ} → Decidable {A = Fin n} _≡_
zero  ≟ zero  = yes refl
zero  ≟ suc y = no λ()
suc x ≟ zero  = no λ()
suc x ≟ suc y with x ≟ y
... | yes x≡y = yes (cong Fin.suc x≡y)
... | no  x≢y = no (λ r → x≢y (suc-injective r))


-- Def.
eq : (φ ψ : PropFormula) → Dec (φ ≡ ψ)

-- Equality with Var.
eq (Var x) ⊤        = no λ()
eq (Var x) ⊥        = no λ()
eq (Var x) (ψ ∧ ψ₁) = no λ()
eq (Var x) (ψ ∨ ψ₁) = no λ()
eq (Var x) (ψ ⊃ ψ₁) = no λ()
eq (Var x) (ψ ⇔ ψ₁) = no λ()
eq (Var x) (¬ ψ)    = no λ()
eq (Var x) (Var x₁) with x ≟ x₁
... | yes refl = yes refl
... | no x≢x₁  = no (λ r → x≢x₁ (var-injective r))

-- Equality with ⊤.
eq ⊤ (Var x)        = no λ()
eq ⊤ ⊥              = no λ()
eq ⊤ (ψ ∧ ψ₁)       = no λ()
eq ⊤ (ψ ∨ ψ₁)       = no λ()
eq ⊤ (ψ ⊃ ψ₁)       = no λ()
eq ⊤ (ψ ⇔ ψ₁)      = no λ()
eq ⊤ (¬ ψ)          = no λ()
eq ⊤ ⊤              = yes refl

-- Equality with ⊥.
eq ⊥ (Var x)        = no λ()
eq ⊥ ⊤              = no λ()
eq ⊥ (ψ ∧ ψ₁)       = no λ()
eq ⊥ (ψ ∨ ψ₁)       = no λ()
eq ⊥ (ψ ⊃ ψ₁)       = no λ()
eq ⊥ (ψ ⇔ ψ₁)       = no λ()
eq ⊥ (¬ ψ)          = no λ()
eq ⊥ ⊥              = yes refl

-- Equality with ∧.
eq (φ ∧ φ₁) (Var x)  = no λ()
eq (φ ∧ φ₁) ⊤        = no λ()
eq (φ ∧ φ₁) ⊥        = no λ()
eq (φ ∧ φ₁) (ψ ∨ ψ₁) = no λ()
eq (φ ∧ φ₁) (ψ ⊃ ψ₁) = no λ()
eq (φ ∧ φ₁) (ψ ⇔ ψ₁) = no λ()
eq (φ ∧ φ₁) (¬ ψ)    = no λ()
eq (φ ∧ φ₁) (ψ ∧ ψ₁) with eq φ ψ | eq φ₁ ψ₁
... | yes refl | yes refl = yes refl
... | yes _    | no φ₁≢ψ₁ = no (λ r → φ₁≢ψ₁ (∧-injective₂ r))
... | no φ≢ψ   | _        = no (λ r → φ≢ψ   (∧-injective₁ r))

-- Equality with ∨.
eq (φ ∨ φ₁) (Var x)  = no λ()
eq (φ ∨ φ₁) ⊤        = no λ()
eq (φ ∨ φ₁) ⊥        = no λ()
eq (φ ∨ φ₁) (ψ ∧ ψ₁) = no λ()
eq (φ ∨ φ₁) (ψ ⊃ ψ₁) = no λ()
eq (φ ∨ φ₁) (ψ ⇔ ψ₁) = no λ()
eq (φ ∨ φ₁) (¬ ψ)    = no λ()
eq (φ ∨ φ₁) (ψ ∨ ψ₁) with eq φ ψ | eq φ₁ ψ₁
... | yes refl | yes refl  = yes refl
... | yes _    | no  φ₁≢ψ₁ = no (λ r → φ₁≢ψ₁ (∨-injective₂ r))
... | no φ≢ψ   | _         = no (λ r → φ≢ψ   (∨-injective₁ r))

-- Equality with ⊃.
eq (φ ⊃ φ₁) (Var x)  = no λ()
eq (φ ⊃ φ₁) ⊤        = no λ()
eq (φ ⊃ φ₁) ⊥        = no λ()
eq (φ ⊃ φ₁) (ψ ∧ ψ₁) = no λ()
eq (φ ⊃ φ₁) (ψ ∨ ψ₁) = no λ()
eq (φ ⊃ φ₁) (ψ ⇔ ψ₁) = no λ()
eq (φ ⊃ φ₁) (¬ ψ)    = no λ()
eq (φ ⊃ φ₁) (ψ ⊃ ψ₁) with eq φ ψ | eq φ₁ ψ₁
... | yes refl | yes refl  = yes refl
... | yes _    | no  φ₁≢ψ₁ = no (λ r → φ₁≢ψ₁ (⊃-injective₂ r))
... | no φ≢ψ   | _         = no (λ r → φ≢ψ   (⊃-injective₁ r))

-- Equality with ⇔.
eq (φ ⇔ φ₁) (Var x)  = no λ()
eq (φ ⇔ φ₁) ⊤        = no λ()
eq (φ ⇔ φ₁) ⊥        = no λ()
eq (φ ⇔ φ₁) (ψ ∧ ψ₁) = no λ()
eq (φ ⇔ φ₁) (ψ ∨ ψ₁) = no λ()
eq (φ ⇔ φ₁) (ψ ⊃ ψ₁) = no λ()
eq (φ ⇔ φ₁) (¬ ψ)    = no λ()
eq (φ ⇔ φ₁) (ψ ⇔ ψ₁) with eq φ ψ | eq φ₁ ψ₁
... | yes refl | yes refl  = yes refl
... | yes _    | no  φ₁≢ψ₁ = no (λ r → φ₁≢ψ₁ (⇔-injective₂ r))
... | no φ≢ψ   | _         = no (λ r → φ≢ψ   (⇔-injective₁ r))

-- Equality with ¬.
eq (¬ φ) (Var x)  = no λ()
eq (¬ φ) ⊤        = no λ()
eq (¬ φ) ⊥        = no λ()
eq (¬ φ) (ψ ∧ ψ₁) = no λ()
eq (¬ φ) (ψ ∨ ψ₁) = no λ()
eq (¬ φ) (ψ ⊃ ψ₁) = no λ()
eq (¬ φ) (ψ ⇔ ψ₁) = no λ()
eq (¬ φ) (¬ ψ) with eq φ ψ
... | yes refl = yes refl
... | no φ≢ψ   = no (λ r → φ≢ψ (¬-injective r))

-- Theorem.
subst
  : ∀ {Γ} {φ ψ}
  → φ ≡ ψ
  → Γ ⊢ φ
  → Γ ⊢ ψ
subst refl o = o

-- Theorem.
substΓ
  : ∀ {Γ₁ Γ₂} {φ}
  → Γ₁ ≡ Γ₂
  → Γ₁ ⊢ φ
  → Γ₂ ⊢ φ
substΓ refl o = o
