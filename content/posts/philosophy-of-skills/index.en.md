---
title: "On the Philosophical Meaning of Skills"
date: 2026-02-06T07:32:27Z
draft: false
translationKey: "posts/philosophy-of-skills"
tags: []
summary: ""
---

## 0. Introduction

Once you put an agent into real work, you quickly find that what it most often gets stuck on isn’t “not being able to think,” but “not having worked in this organization.” The default structure, tone, and review focus your team expects for the same report; which checks are hard rules vs. hard-earned priorities for the same deployment; which information can never be sent out and which wording must be retained in external communication—these things usually aren’t in public knowledge, and they aren’t in model parameters either. They live in an organization’s conventions, checklists, incident postmortems, and apprenticeship-style knowledge transfer.

What Anthropic calls Agent Skills in their engineering post targets exactly this kind of “how we do things” experience: packaging practical, procedural knowledge into “folderized capability packs” that agents can discover and load on demand—packs that may include instructions, scripts, and resources. They even make the analogy bluntly: writing a skill is much like writing an onboarding guide for a new hire—capturing, packaging, and sharing ways of working, so a general-purpose agent can become a specialized agent adapted to a particular context.

When this mechanism was released as an open standard in late 2025—explicitly emphasizing cross-platform portability—it stopped being merely a “prompt trick” for a product and began to look more like infrastructure: experience is objectified, distributable, composable, and auditable.

But that shift is, in itself, a philosophical question.

---

## 1. The technical outline of Skills—and its philosophical questions

In its simplest form, a skill is a directory whose core file is `SKILL.md`.

It must begin with YAML front matter containing at least `name` and `description`. When an agent starts, it preloads the `name`/`description` of every installed skill into the system prompt; when a skill is judged relevant, the full body of `SKILL.md` is read into context.

The keyword here is progressive disclosure: load a tiny “catalog-level hint” first, then load the full text and referenced files on demand. As a skill grows more complex, you can split finer details into additional files for the agent to read only when needed.

Anthropic even describes this as a “manual-style layering”: catalog (metadata) → chapter (`SKILL.md`) → appendices (`references/assets/scripts`). For agents with filesystem access and code execution, the amount of context a skill directory can carry is “almost unbounded,” because you don’t need to stuff everything into a context window at once—you read and execute only when necessary.

Just as important is drawing the boundary clearly: in today’s implementations, “injecting” skills is mainly an engineering-neutral mechanism—concatenating external file content into the system prompt and context to influence reasoning and planning. It does not inherently govern tool protocols, communication, or permissions. The fact that the open specification includes an `allowed-tools` field is precisely evidence of this: it looks like an early “permission declaration / pre-approval list,” is marked Experimental, and explicitly notes that “support varies by implementation.” In other words, whether it’s enforced—and how—is still largely decided by the host runtime/product layer.

Up to this point, Skills might look like prompt engineering made more systematic. The interesting part is that it turns “experience” into an object that can be stored, distributed, invoked, and audited. And that object naturally carries directory structure, version metadata, and optional scripts and resources—it already resembles a maintainable knowledge artifact, rather than a one-off conversation. (Different implementations may include slightly different fields, and future iterations may add more—so the details aren’t the point.)

---

## 2. From know-how to “callable memory”: Skills externalizes experience as a portable organizational “cerebellum”

Engineering-wise, skills solve a “how to do it” problem. In philosophy, there’s a classic distinction for this kind of knowledge: know-how vs. know-that.

In the Rylean tradition, know-how is not equivalent to “having a pile of propositions,” nor is it “memorizing rules in your head and then executing them.” If anything, in many cases “being able to do” is logically prior to “being able to say.”

Anthropic’s positioning of Agent Skills—as onboarding-guide-style packaging of procedural knowledge—is almost an engineering response to that distinction: making organizational know-how as readable, executable, and reusable for agents as possible.

But you immediately run into a sharper boundary: Polanyi’s famous line, “we know more than we can tell.” Many practical capabilities are tacit: you can do them, but you can’t fully articulate the rules.

The practical strategy of skills isn’t to “eliminate tacit knowledge,” but to slice it: solidify what can be written down (processes, templates, red lines, common pitfalls, exception handling) into manuals and checklists, while leaving what’s hard to verbalize but still crucial to the model’s situational reasoning—and to human review mechanisms as the backstop. How well you make that cut largely determines the ceiling of value for skills.

Push the lens one step outward and you’ll see an unexpected resonance between skills and Bernard Stiegler’s discussion of “technical memory”: human memory and subjectivity don’t happen only inside the brain—they’re externalized and shaped by technical media (tertiary retention / technical memory).

This is where the philosophical meaning of skills comes into focus: it turns organizational experience into a portable external memory environment. Experience no longer lives only “in a veteran employee’s head” or “in the atmosphere of a retrospective meeting.” It becomes directories, Markdown, scripts, and reference materials—memory modules that can be installed, updated, and reused.

This also explains a frequently underestimated but very practical point: although skills are mainly “for agents,” they are naturally also “for humans to learn,” because their writing format is defined from day one as an onboarding guide.

A well-written `SKILL.md` is, in essence, a high-quality experience textbook: it compresses key invariants, key steps, key risks, common pitfalls, and exception handling into a readable structure, making “doing it right” more repeatable.

The value of “writing experience as checklists/manuals” has long been validated in the human world. Take the surgical safety checklist: in a WHO news summary, the introduction of a checklist is reported to reduce major complications from 11% to 7%, and in-hospital deaths from 1.5% to 0.8% (figures popularized from the multicenter study and its subsequent communications).

This doesn’t make surgeons smarter. It reduces errors where people “knew it” but didn’t do it in a complex system. The role of skills for agents (and for new hires) is very similar: fix easily forgotten, easily skipped, easily misunderstood experience into external memory so execution becomes more reliable.

---

## 3. Writing down rules isn’t the same as using them: a Wittgensteinian reminder

Much of a skill’s content is rules and processes. But Wittgensteinian rule-following discussions remind us that rules do not automatically carry their own mode of application; the very same rule can be interpreted in different ways, and “following a rule” ultimately depends on a community’s usage and practical context.

Applied back to skills, you get a very engineering-style conclusion: the key to reducing misuse isn’t writing longer procedures—it’s writing harder boundaries for “how this is supposed to be used.” The Agent Skills open specification is almost a translation of that philosophy into writing guidance: it recommends step-by-step instructions, input/output examples, common edge cases, and notes that the full body will be loaded when activated—so if it’s too long, split it into `references`.

From there, the next step is natural: as skills scale, examples/counterexamples will start to look like “unit tests,” and boundary cases and failure modes will start to look like “regression cases.” A mature skill system will gradually grow things like:

In writing: it’s no longer just a “manual,” but an “executable contract with examples”—what the input is, what the output is, when you must stop, when you must escalate, when you should rather be slow than gamble.

In operations: it’s no longer “a folder sitting there,” but something you monitor—trigger rate, success rate, clustered failure causes, common mis-trigger paths, rollback strategies—monitoring skills the way you monitor APIs.

Philosophically, this means rules are no longer treated as “the source of meaning,” but as “boundary devices for action”: they don’t guarantee correctness, but they confine error into a range that is visible, fixable, and reviewable.

---

## 4. `technê` can be manualized; `phronêsis` cannot

Aristotle distinguishes `technê` (repeatable craft / productive knowledge) from `phronêsis` (practical wisdom). In his ethical discussions, one key claim is that practical wisdom cannot be gained merely by learning general rules; it must be formed through practice—an ability to see, in each situation, which choice is better.

That sentence is almost the philosophical “ceiling” of skills: skills are excellent at solidifying `technê`—processes, templates, checklists, tool usage—but they cannot fully write `phronêsis` into rules. A mature skill system should acknowledge this, and place the most expensive experience precisely at the “judgment points”:

- When you must stop and ask a human (e.g., compliance, privacy, external messaging, irreversible changes).
- When you must escalate (e.g., impact exceeds a threshold, cross-team coordination, elevated risk level).
- When you should rather be slow than gamble (e.g., money, production, legal and safety-related actions).

That’s why “more advanced skills” are often not longer SOPs, but clearer halt points and escalation conditions—leaving space for judgment, so process serves practical wisdom rather than turning action into blind execution.

---

## 5. When experience becomes distributable and triggerable, Skills needs governance even more

Once skills enter organizational use, they don’t merely spread knowledge—they also define what counts as “the correct way to do things.” In Foucault’s discussion of modern power, governmentality (the rationality of governance) emphasizes the role of norms, techniques, and procedures: governance is not only about issuing commands, but about shaping action through fine-grained mechanisms.

The stronger a skill’s “normalizing” power becomes, the more it resembles a micro-governance device: it solidifies “how the organization believes things should be done” into default paths, making deviations more visible—or even harder.

This governance dimension shows most directly in security and the supply chain. Anthropic explicitly warns in their safety notes that malicious skills could induce data exfiltration or trigger unintended actions. They recommend installing only from trusted sources; for less trusted sources, audit the content and code dependencies, and watch for instructions that involve external network connections.

Once skills can bundle scripts and steer tool calls, risk escalates from “writing a bad prompt” to “capability supply-chain risk.” The specification’s `allowed-tools` looks like a manifest seed: it declares which tools a skill is pre-approved to use, though enforcement depends on the implementation.

In other words: scaling skills will inevitably demand a thicker governance shell—least privilege, audits, signing, staged releases, rollback mechanisms, traceable change records. These won’t be “nice to have”; they’ll be the bedrock for whether the system can be used with confidence.

And this is exactly where “whether a skill is written well” stops being merely a writing problem and becomes part of organizational governance capacity: who can publish, who reviews, who enables, how incidents are investigated and responsibilities assigned, how rollbacks happen—skills will force these questions into the open.

---

## 6. Skills vs. `/prompts` vs. slash commands: from personal hotkeys to organizational experience assets

The comparison is simple: one category is explicitly invoked macro commands; the other is discoverable experience packages that can be loaded on demand.

OpenAI Codex’s Custom Prompts belongs to the former: it turns Markdown files into slash commands, but they must be called explicitly. By default, they live locally (e.g., `~/.codex`) and are not shared with a repository. The official docs even state plainly: if you want to share prompts—or want Codex to invoke them implicitly—use skills.

Claude Code’s custom slash commands are almost structurally identical: store commonly used prompts as Markdown files, organized by project/personal scope; put project commands under `.claude/commands/`; invoke them explicitly via `/<command-name> [arguments]`.

Skills belongs to the latter: in Codex’s skills documentation, a skill is defined as a directory where `SKILL.md` captures a capability, optionally including `scripts/resources/assets`. It similarly emphasizes progressive disclosure, and provides both explicit and implicit activation (e.g., explicitly selecting via `/skills`, or being auto-triggered by task matching). Codex also introduces scope and override priority: for two skills with the same name, a higher-priority scope overrides a lower-priority scope.

Philosophically, this isn’t just a “feature difference.” It’s a different kind of object. Macro commands are closer to personal tricks (they only need to work well for you); skills are closer to organizational experience assets—transferable, governable, contestable, rollbackable. They turn “ways of working” from personal habits into artifacts that can enter an engineering system.

---

## 7. Looking ahead: when Skills increasingly resembles packages in the AI era

If I had to offer a more concrete mental model, I’d say the future of skills will likely move toward software packages: installable, versioned, dependency-managed, maintainable, auditable. It’s not a single prompt—it’s a unit of capability that can be distributed and evolved.

The analogy holds because skills already look like packages: a clear directory boundary, an entry file (`SKILL.md`), metadata fields (license/compatibility/metadata/version), and bundled scripts/resources.

Of course, an analogy is never a perfect isomorphism: package interfaces are enforced strictly by compilers/interpreters, while skill “interfaces” are still largely driven by natural language and model interpretation. Determinism comes more from the scripted parts and the runtime’s permissions and verification mechanisms. Precisely because they aren’t fully equivalent, the analogy is useful: it tells us where future engineering “must-haves” are likely to accumulate.

The first layer will be standardized distribution and assembly, rather than manually copying folders. Since Agent Skills is an open standard emphasizing cross-platform portability, a mature ecosystem will naturally converge on an experience of “install, upgrade, pin versions, roll back, disable.”

The second layer will emphasize versioning, compatibility, and dependencies. The specification already provides compatibility and metadata/version fields, and recommends scripts be self-contained or clearly declare dependencies. As organizational workflows become inherently compositional, these fields will shift from “optional info” to “default requirements.” Further still, explicit “skills depend on skills” relationships will emerge: one high-level skill orchestrates, while foundational skills specialize in particular steps (querying a data warehouse, charting, document generation, messaging review), forming a stable capability graph.

The third layer will push “writing guidance” into “verifiable capability.” The spec recommends examples and edge cases; once skills become organizational dependencies, what’s most valuable is predictability: run minimal regression examples before release, rerun them after upgrades; record failure modes in production to create an iterative loop.

The fourth layer will move permissions and side-effect declarations from “soft advice” to “hard mechanisms.” `allowed-tools` is manifest-like, and Anthropic’s safety warning makes supply-chain risk concrete. As the skills ecosystem grows, “trust” will shift from interpersonal relationships to mechanisms: signatures, review, staged rollouts, least privilege, sandboxing, and audit trails. Only after that will skills truly become infrastructure that you can confidently let agents execute automatically.

The fifth layer will turn “learning for humans” from a byproduct into an explicit goal. Because skills are written as onboarding guides, they will naturally feed organizational training: new hires learn skills to learn the organization’s ways of working; veterans update skills to make experience explicit and solidify it into organizational memory.

Finally, a reminder in the opposite direction: Heidegger’s discussion of Gestell (enframing) warns that technological modernity increasingly frames the world as “dispatchable resources,” flattening meaning and context.

Making skills more package-like will strongly push workflows toward scripting and modularization: reliability rises, efficiency rises—but it can also miswrite “defensible judgment” into “executable defaults.” A mature skills ecosystem should actively leave room for `phronêsis`: force slowdowns at critical points, require reasons, require second confirmations—so “executable” doesn’t swallow “defensible.”

---

## Conclusion

If you treat skills as “just another kind of prompt engineering,” it’s indeed not worth much ink. But if you treat it as a device that externalizes experience into callable memory—distributable, composable, auditable, and even capable of educating humans—its philosophical meaning becomes clear: skills is not making the model smarter; it is changing how experience exists, how it is transmitted, how it enters action, and ultimately how it shapes organizations.

---

## References

- Anthropic engineering blog: “Equipping agents for the real world with Agent Skills” (progressive disclosure, onboarding-guide analogy, security notes, future directions)
- Agent Skills open specification (`SKILL.md` format, recommended sections, optional dirs, `allowed-tools`, progressive disclosure)
- OpenAI Codex: Agent Skills docs (explicit/implicit activation, scope override priority, directory structure)
- OpenAI Codex: Custom Prompts (explicit invocation, local directory, not shared with a repo; a contrast to skills)
- Claude Code: Slash commands (custom commands, project/personal scope, `.claude/commands/`)
- Stiegler and tertiary retention (externalized technical memory)
- WHO summary of surgical safety checklist outcomes
- Haynes et al. (2009) surgical safety checklist study (abstract/paper entry)
- Wittgenstein on rule-following (SEP)
- Aristotle on practical wisdom `phronêsis` (SEP)
- Foucault and governmentality (SEP)
- Heidegger and Gestell / enframing (SEP)
- Ryle: knowing-how / knowing-that (SEP)
- Polanyi: *The Tacit Dimension* (“we can know more than we can tell”)

```
【Recommended reading list】
1. https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills
2. https://agentskills.io/specification
3. https://developers.openai.com/codex/skills/
4. https://developers.openai.com/codex/custom-prompts/
5. https://code.claude.com/docs/en/slash-commands
6. https://pmc.ncbi.nlm.nih.gov/articles/PMC7903928/
7. https://www.who.int/news/item/11-12-2010-checklist-helps-reduce-surgical-complications-deaths
8. https://pubmed.ncbi.nlm.nih.gov/19144931/
9. https://plato.stanford.edu/entries/rule-following/
10. https://plato.stanford.edu/entries/aristotle-ethics/
11. https://plato.stanford.edu/entries/foucault/
12. https://plato.stanford.edu/entries/heidegger/
13. https://plato.stanford.edu/entries/ryle/knowing-how.html
14. https://plato.stanford.edu/entries/knowledge-how/
15. https://press.uchicago.edu/ucp/books/book/chicago/T/bo6035368.html

```

{{< comments >}}
