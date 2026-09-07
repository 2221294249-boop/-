#!/usr/bin/env bash
set -euo pipefail

scientific_sha="9cf7d9aea7d84754db4c167ab04b299d33c444bc"
nature_sha="287ee37542620711a56c7c58a73f44ef5c2bede0"
academic_sha="925975e933a20893b81681d925a3404e3b7f73b7"

sync_tmp="$(mktemp -d)"
trap 'rm -rf "$sync_tmp"' EXIT

fetch_pinned_repo() {
    local url="$1"
    local sha="$2"
    local destination="$3"

    git init -q "$destination"
    git -C "$destination" remote add origin "$url"
    git -C "$destination" fetch -q --depth 1 origin "$sha"
    test "$(git -C "$destination" rev-parse FETCH_HEAD)" = "$sha"
    git -C "$destination" checkout -q --detach FETCH_HEAD
}

fetch_pinned_repo "https://github.com/K-Dense-AI/scientific-agent-skills.git" "$scientific_sha" "$sync_tmp/scientific"
fetch_pinned_repo "https://github.com/Yuan1z0825/nature-skills.git" "$nature_sha" "$sync_tmp/nature"
fetch_pinned_repo "https://github.com/Imbad0202/academic-research-skills-codex.git" "$academic_sha" "$sync_tmp/academic"

skills_destination="plugins/research-skills/skills"
rm -rf "$skills_destination"
mkdir -p "$skills_destination"

for skill in scientific-brainstorming literature-review statistical-analysis scientific-visualization; do
    cp -a "$sync_tmp/scientific/skills/$skill" "$skills_destination/"
done

for skill in nature-academic-search nature-figure nature-writing nature-polishing nature-reviewer nature-response nature-data nature-paper2ppt nature-shared; do
    cp -a "$sync_tmp/nature/skills/$skill" "$skills_destination/"
done

cp -a "$sync_tmp/academic/skills/academic-research-suite" "$skills_destination/"

for skill_directory in "$skills_destination"/*; do
    test -f "$skill_directory/SKILL.md"
done

test "$(find "$skills_destination" -mindepth 1 -maxdepth 1 -type d | wc -l)" -eq 14

git add "$skills_destination"
if git diff --cached --quiet; then
    echo "Pinned research skills are already synchronized."
    exit 0
fi

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git commit -m "Vendor pinned research skills"
git push
