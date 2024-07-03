module TypeIO.DefsRW where

import TypeIO.Defs
import RW.Base
import System.IO

instance ReadWrite MyDef1 where
  readRW strs ('0' : r0) = (MyCons1 a' b',r2)
    where
      (a',r1) = readRW strs r0
      (b',r2) = readRW strs r1
  readRW strs ('1' : r0) = (MyCons2 a',r1)
    where
      (a',r1) = readRW strs r0

  showRW params strs0 (MyCons1 a' b') = (strs2,showChar '0' . (show1 . show2))
    where
      (strs1,show1) = showRW params strs0 a'
      (strs2,show2) = showRW params strs1 b'
  showRW params strs0 (MyCons2 a') = (strs1,showChar '1' . show1)
    where
      (strs1,show1) = showRW params strs0 a'

  writeRW params h (MyCons1 a' b') strs =
    hPutChar h '0' >> (writeRW params h a' strs >>= writeRW params h b')
  writeRW params h (MyCons2 a') strs =
    hPutChar h '1' >> writeRW params h a' strs

  typeOf _ = monoRWType "MyDef1"

instance ReadWrite a => ReadWrite (MyMaybe a) where
  readRW strs ('0' : r0) = (MyJust a',r1)
    where
      (a',r1) = readRW strs r0
  readRW strs ('1' : r0) = (MyNothing,r0)

  showRW params strs0 (MyJust a') = (strs1,showChar '0' . show1)
    where
      (strs1,show1) = showRW params strs0 a'
  showRW params strs0 MyNothing = (strs0,showChar '1')

  writeRW params h (MyJust a') strs =
    hPutChar h '0' >> writeRW params h a' strs
  writeRW params h MyNothing strs = hPutChar h '1' >> return strs

  typeOf n = RWType "MyMaybe" [typeOf (get_a n)]
    where
      get_a :: MyMaybe a' -> a'
      get_a _ = failed

instance ReadWrite a => ReadWrite (MyProblemA a) where
  readRW strs r0 = (MyProblemA a',r1)
    where
      (a',r1) = readRW strs r0

  showRW params strs0 (MyProblemA a') = (strs1,show1)
    where
      (strs1,show1) = showRW params strs0 a'

  writeRW params h (MyProblemA a') strs = writeRW params h a' strs

  typeOf n = RWType "MyProblemA" [typeOf (get_a n)]
    where
      get_a :: MyProblemA a' -> a'
      get_a _ = failed

instance ReadWrite a => ReadWrite (MyProblemB a) where
  readRW strs ('0' : r0) = (MyProblemB a',r1)
    where
      (a',r1) = readRW strs r0
  readRW strs ('1' : r0) = (Ok a',r1)
    where
      (a',r1) = readRW strs r0

  showRW params strs0 (MyProblemB a') = (strs1,showChar '0' . show1)
    where
      (strs1,show1) = showRW params strs0 a'
  showRW params strs0 (Ok a') = (strs1,showChar '1' . show1)
    where
      (strs1,show1) = showRW params strs0 a'

  writeRW params h (MyProblemB a') strs =
    hPutChar h '0' >> writeRW params h a' strs
  writeRW params h (Ok a') strs = hPutChar h '1' >> writeRW params h a' strs

  typeOf n = RWType "MyProblemB" [typeOf (get_a n)]
    where
      get_a :: MyProblemB a' -> a'
      get_a _ = failed

instance ReadWrite a => ReadWrite (ThreeCycleA a) where
  readRW strs r0 = (ThreeCycleA a',r1)
    where
      (a',r1) = readRW strs r0

  showRW params strs0 (ThreeCycleA a') = (strs1,show1)
    where
      (strs1,show1) = showRW params strs0 a'

  writeRW params h (ThreeCycleA a') strs = writeRW params h a' strs

  typeOf n = RWType "ThreeCycleA" [typeOf (get_a n)]
    where
      get_a :: ThreeCycleA a' -> a'
      get_a _ = failed

instance ReadWrite a => ReadWrite (ThreeCycleB a) where
  readRW strs ('0' : r0) = (ThreeCycleB a',r1)
    where
      (a',r1) = readRW strs r0
  readRW strs ('1' : r0) = (Yay a',r1)
    where
      (a',r1) = readRW strs r0

  showRW params strs0 (ThreeCycleB a') = (strs1,showChar '0' . show1)
    where
      (strs1,show1) = showRW params strs0 a'
  showRW params strs0 (Yay a') = (strs1,showChar '1' . show1)
    where
      (strs1,show1) = showRW params strs0 a'

  writeRW params h (ThreeCycleB a') strs =
    hPutChar h '0' >> writeRW params h a' strs
  writeRW params h (Yay a') strs = hPutChar h '1' >> writeRW params h a' strs

  typeOf n = RWType "ThreeCycleB" [typeOf (get_a n)]
    where
      get_a :: ThreeCycleB a' -> a'
      get_a _ = failed

instance ReadWrite a => ReadWrite (ThreeCycleC a) where
  readRW strs ('0' : r0) = (ThreeCycleC a',r1)
    where
      (a',r1) = readRW strs r0
  readRW strs ('1' : r0) = (Good a',r1)
    where
      (a',r1) = readRW strs r0

  showRW params strs0 (ThreeCycleC a') = (strs1,showChar '0' . show1)
    where
      (strs1,show1) = showRW params strs0 a'
  showRW params strs0 (Good a') = (strs1,showChar '1' . show1)
    where
      (strs1,show1) = showRW params strs0 a'

  writeRW params h (ThreeCycleC a') strs =
    hPutChar h '0' >> writeRW params h a' strs
  writeRW params h (Good a') strs = hPutChar h '1' >> writeRW params h a' strs

  typeOf n = RWType "ThreeCycleC" [typeOf (get_a n)]
    where
      get_a :: ThreeCycleC a' -> a'
      get_a _ = failed

instance ReadWrite a => ReadWrite (Escape a) where
  readRW strs r0 = (VeryGood a',r1)
    where
      (a',r1) = readRW strs r0

  showRW params strs0 (VeryGood a') = (strs1,show1)
    where
      (strs1,show1) = showRW params strs0 a'

  writeRW params h (VeryGood a') strs = writeRW params h a' strs

  typeOf n = RWType "Escape" [typeOf (get_a n)]
    where
      get_a :: Escape a' -> a'
      get_a _ = failed

instance (ReadWrite a
         ,ReadWrite b
         ,ReadWrite c
         ,ReadWrite d
         ,ReadWrite e
         ,ReadWrite f
         ,ReadWrite g) => ReadWrite (Lots a b c d e f g) where
  readRW strs r0 = (Nah,r0)

  showRW params strs0 Nah = (strs0,showString "")

  writeRW params h Nah strs = return strs

  typeOf n =
    RWType "Lots"
     [typeOf (get_a n)
     ,typeOf (get_b n)
     ,typeOf (get_c n)
     ,typeOf (get_d n)
     ,typeOf (get_e n)
     ,typeOf (get_f n)
     ,typeOf (get_g n)]
    where
      get_a :: Lots a' b' c' d' e' f' g' -> a'
      get_a _ = failed
      get_b :: Lots a' b' c' d' e' f' g' -> b'
      get_b _ = failed
      get_c :: Lots a' b' c' d' e' f' g' -> c'
      get_c _ = failed
      get_d :: Lots a' b' c' d' e' f' g' -> d'
      get_d _ = failed
      get_e :: Lots a' b' c' d' e' f' g' -> e'
      get_e _ = failed
      get_f :: Lots a' b' c' d' e' f' g' -> f'
      get_f _ = failed
      get_g :: Lots a' b' c' d' e' f' g' -> g'
      get_g _ = failed

version_TypeIO_DefsRW :: Float
version_TypeIO_DefsRW = 0.1