from os import getenv
from pathlib import Path

from dotenv import load_dotenv
from pyprojroot import here

root = here()
notebooks_dir = root / "notebooks"


def get_data_dir(
    absolute_var: str = "DATA_DIR",
    relative_var: str = "RELATIVE_DATA_DIR",
    root: Path | None = None,
) -> Path:
    """
    Returns path to the data directory, which by default points to the 'data' folder inside the Python project-root. Can be
    overridden by passing either an absolute or relative path segment through its specified environment variable.

    Parameters
    ----------
    absolute_var : str
        Name of environment variable which specifies absolute filepath to data-folder.
    relative_var : str
        Name of environment variable which specifies filepath to data-folder, relative to the project-root folder.
    root : Path | None, default None
        Path to project-root folder. If set to None (default), root is autodetected using pyprojroot.here().

    Returns
    -------
    data_dir : Path
        Path pointing to data directory.
    """

    absolute_dir = getenv(absolute_var)
    if absolute_dir is not None:
        return Path(absolute_dir)

    if root is None:
        root = here()

    relative_dir = getenv(relative_var)
    if relative_dir is not None:
        return root / relative_dir

    return root / "data"


load_dotenv(dotenv_path=(root / ".env"))
data_dir = get_data_dir()
