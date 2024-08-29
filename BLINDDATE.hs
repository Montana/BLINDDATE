import System.Environment (getArgs)
import System.Process (system)
import System.Random (randomRIO)
import Control.Monad (forM_, when)

buildCommand :: FilePath -> FilePath -> [String] -> String
buildCommand input output operations =
  "ncap2 -s '" ++ concatOperations operations ++ "' " ++ input ++ " -o " ++ output
  where
    concatOperations :: [String] -> String
    concatOperations ops = concatMap (++ "; ") ops

extractVariable :: FilePath -> FilePath -> String -> IO ()
extractVariable input output var =
  system ("ncks -v " ++ var ++ " " ++ input ++ " -o " ++ output) >> return ()

renameVariable :: FilePath -> String -> String -> IO ()
renameVariable file oldName newName =
  system ("ncrename -v " ++ oldName ++ "," ++ newName ++ " " ++ file) >> return ()

blindDate :: FilePath -> FilePath -> IO ()
blindDate inputFile outputFile = do
  shiftDays <- randomRIO (-365, 365)
  let operation = "time=time+" ++ show shiftDays ++ ".0"
  let command = buildCommand inputFile outputFile [operation]
  putStrLn $ "Applying BLINDDATE: shifting time by " ++ show shiftDays ++ " days."
  _ <- system command
  putStrLn "BLINDDATE operation complete."

main :: IO ()
main = do
  args <- getArgs
  case args of
    ("BLINDDATE":inputFile:outputFile:_) -> blindDate(inputFile, outputFile)
    (inputFile:outputFile:ops) -> do
      when (null ops) $ putStrLn "No operations provided. Exiting."
      let command = buildCommand inputFile outputFile ops
      putStrLn $ "Running command: " ++ command
      _ <- system command
      putStrLn "Processing complete."
    _ -> do
      putStrLn "Usage:"
      putStrLn "  AdvancedProcessNetCDF <input.nc> <output.nc> <operations...>"
      putStrLn "    Example: AdvancedProcessNetCDF input.nc output.nc 'var1=var1*2' 'var2=var1+var2'"
      putStrLn "  AdvancedProcessNetCDF BLINDDATE <input.nc> <output.nc>"
      putStrLn "    Example: AdvancedProcessNetCDF BLINDDATE input.nc output.nc"
      putStrLn "Additional Functions:"
      putStrLn "  - extractVariable <input.nc> <output.nc> <variable>"
      putStrLn "  - renameVariable <file.nc> <oldVar> <newVar>"
