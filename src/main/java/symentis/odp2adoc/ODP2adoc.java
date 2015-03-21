package symentis.odp2adoc;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.GnuParser;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.Options;
import org.jdom.transform.JDOMSource;
import org.jopendocument.dom.ODPackage;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.List;

public class ODP2adoc {

	private static final String OUTPUT_ARG = "output";

	public static void main(String[] args) throws Exception {

		Options options = new Options();

		OptionBuilder.hasArg();
		OptionBuilder.withArgName(OUTPUT_ARG);
		OptionBuilder.withDescription("asciidoctor outout file name");
		options.addOption(OptionBuilder.create(OUTPUT_ARG));

		GnuParser parser = new GnuParser();

		CommandLine commandLine = parser.parse(options, args);

		List<?> argList = commandLine.getArgList();

		if (argList.isEmpty()) {
			System.out.println("no required ODP (OpenOffice, LibreOffice) document");
			return;
		}

		String odpFileName = (String) argList.get(0);
		File odpFile = new File(odpFileName);

		if (!odpFile.exists()) {
			System.out.println(String.format("%s doesn't exist", odpFileName));
			return;
		}

		String adocFileName = (String) commandLine.getParsedOptionValue(OUTPUT_ARG);
		if (adocFileName == null) {
			adocFileName = odpFile.getName() + ".adoc";
		}

		File adocFile = new File(adocFileName);

		ODPackage openDocument = new ODPackage(odpFile);

		TransformerFactory factory = TransformerFactory.newInstance();
		Transformer transformer = factory.newTransformer(new StreamSource(getStylesheet()));
        BufferedWriter writer = new BufferedWriter(new FileWriter(adocFile));
		transformer.transform(new JDOMSource(openDocument.getContent().getDocument()), new StreamResult(writer));

        Files.readAllLines(adocFile.toPath()).forEach(System.out::println);
	}

	private static InputStream getStylesheet() {
		return ODP2adoc.class.getResourceAsStream("/default-odp-adoc.xsl");
	}

}
